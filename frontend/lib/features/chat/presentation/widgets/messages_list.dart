part of 'widgets.dart';

class MessagesList extends ConsumerStatefulWidget {
  final String chatId;

  const MessagesList({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends ConsumerState<MessagesList> {
  bool _isLoadingOlder = false;
  bool _isLoadingNewer = false;
  bool _initialScrollDone = false;
  bool _positionListenerEnabled = false;
  bool _isNavigatingToMessage = false;
  bool _isHandlingScrollAction = false;
  bool _blockAutoLoad = false;
  int? _lastFirstVisibleIndex;
  Timer? _readReceiptDebounce;
  final Set<String> _processedMessageIds = {};
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(_onPositionChange);
  }

  @override
  void dispose() {
    _itemPositionsListener.itemPositions.removeListener(_onPositionChange);
    _readReceiptDebounce?.cancel();
    _readReceiptDebounce = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(MessagesList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.chatId != widget.chatId) {
      _initialScrollDone = false;
      _positionListenerEnabled = false;
      _isLoadingOlder = false;
      _isLoadingNewer = false;
      _isNavigatingToMessage = false;
      _blockAutoLoad = false;
      _isHandlingScrollAction = false;
      _lastFirstVisibleIndex = null;
      _processedMessageIds.clear();
    }
  }

  void _onPositionChange() {
    if (!_positionListenerEnabled) return;
    if (_isNavigatingToMessage || _blockAutoLoad) return;

    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    final messageState = ref.read(messageProvider);
    if (messageState is! MessageStateSuccess) return;

    final firstVisibleIndex = positions
        .where((p) => p.itemLeadingEdge >= 0 && p.itemLeadingEdge < 1)
        .map((p) => p.index)
        .fold<int?>(null, (min, index) => min == null ? index : (index < min ? index : min));

    if (firstVisibleIndex == null) return;

    _lastFirstVisibleIndex = firstVisibleIndex;

    final lastVisibleIndex = positions
        .where((p) => p.itemTrailingEdge > 0 && p.itemLeadingEdge < 1)
        .map((p) => p.index)
        .fold<int?>(null, (max, index) => max == null ? index : (index > max ? index : max));

    if (firstVisibleIndex <= 5 &&
        messageState.hasMoreOlder &&
        !_isLoadingOlder &&
        !_isNavigatingToMessage) {
      _loadOlderMessages();
    }

    if (lastVisibleIndex != null &&
        lastVisibleIndex >= messageState.messages.length - 5 &&
        messageState.hasMoreNewer &&
        !_isLoadingNewer &&
        !_isNavigatingToMessage) {
      _loadNewerMessages();
    }

    _checkVisibleMessagesForRead(positions, messageState.messages);
  }

  void _checkVisibleMessagesForRead(
      Iterable<ItemPosition> positions,
      List<MessageEntity> messages) {

    final visibleIndices = positions
        .where((p) => p.itemTrailingEdge > 0 && p.itemLeadingEdge < 1)
        .map((p) => p.index)
        .toSet();

    if (visibleIndices.isEmpty) return;

    final visibleMessageIds = visibleIndices
        .where((index) => index >= 0 && index < messages.length)
        .map((index) => messages[index].id)
        .toList();

    if (visibleMessageIds.isEmpty) return;

    _readReceiptDebounce?.cancel();

    _readReceiptDebounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        ref.read(messageProvider.notifier).markMessagesAsReadOnView(
          visibleMessageIds,
        );
      }
    });
  }

  Future<void> _loadOlderMessages() async {
    if (_isLoadingOlder) return;

    final currentItemCount = _getCurrentMessageCount();

    setState(() {
      _isLoadingOlder = true;
    });

    try {
      await ref.read(messageProvider.notifier).loadOlderMessages();

      if (_initialScrollDone && mounted) {
        final newItemCount = _getCurrentMessageCount();
        final addedCount = newItemCount - currentItemCount;

        if (addedCount > 0 && _itemScrollController.isAttached) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_itemScrollController.isAttached) {
              _itemScrollController.jumpTo(
                index: addedCount,
              );
            }
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingOlder = false;
        });
      }
    }
  }

  Future<void> _loadNewerMessages() async {
    if (_isLoadingNewer) return;

    final currentFirstVisibleIndex = _lastFirstVisibleIndex;

    setState(() {
      _isLoadingNewer = true;
    });

    try {
      await ref.read(messageProvider.notifier).loadNewerMessages();

      if (_initialScrollDone && mounted && currentFirstVisibleIndex != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_itemScrollController.isAttached) {
            _itemScrollController.jumpTo(
              index: currentFirstVisibleIndex,
            );
          }
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingNewer = false;
        });
      }
    }
  }

  int _getCurrentMessageCount() {
    final messageState = ref.read(messageProvider);
    if (messageState is MessageStateSuccess) {
      return messageState.messages.length;
    }
    return 0;
  }

  void _scrollToPosition(int index) {
    if (!_initialScrollDone && mounted) {
      _isNavigatingToMessage = true;
      _blockAutoLoad = true;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_itemScrollController.isAttached) {
          _itemScrollController.jumpTo(index: index);

          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              setState(() {
                _initialScrollDone = true;
                _positionListenerEnabled = true;
                _isNavigatingToMessage = false;
                _blockAutoLoad = false;
              });
            }
          });
        } else {
          setState(() {
            _initialScrollDone = true;
            _positionListenerEnabled = true;
            _isNavigatingToMessage = false;
            _blockAutoLoad = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(messageProvider);

    ref.listen<({String messageId, String messageDate})?>(
      scrollToSentMessageActionProvider,
          (previous, next) {
        if (next != null && !_isHandlingScrollAction) {
          _handleScrollToSentMessage(next.messageId, next.messageDate);
        }
      },
    );

    if (messageState is MessageStateSuccess && !_initialScrollDone) {
      final targetIndex = messageState.firstUnreadIndex ??
          (messageState.messages.isNotEmpty ? messageState.messages.length - 1 : 0);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_initialScrollDone && mounted) {
          _scrollToPosition(targetIndex);
        }
      });
    }

    return switch (messageState) {
      MessageStateInitial() => _buildEmptyState(),
      MessageStateLoading() => _buildLoadingState(),
      MessageStateSuccess(
      messages: final messages,
      hasMoreOlder: final hasMoreOlder,
      hasMoreNewer: final hasMoreNewer,
      isLoadingMore: final isLoadingMore,
      isLoadingNewer: final isLoadingNewer,
      firstUnreadIndex: final firstUnreadIndex,
      ) =>
          _buildMessagesList(
            messages,
            hasMoreOlder: hasMoreOlder,
            hasMoreNewer: hasMoreNewer,
            isLoadingMore: isLoadingMore || _isLoadingOlder,
            isLoadingNewer: isLoadingNewer || _isLoadingNewer,
            firstUnreadIndex: firstUnreadIndex,
          ),
      MessageStateError(error: final error) =>
          _buildErrorState(error.toString()),
    };
  }

  Widget _buildMessagesList(
      List<MessageEntity> messages, {
        required bool hasMoreOlder,
        required bool hasMoreNewer,
        required bool isLoadingMore,
        required bool isLoadingNewer,
        int? firstUnreadIndex,
      }) {
    if (messages.isEmpty) {
      return _buildEmptyChatState();
    }

    return Column(
      children: [
        if (isLoadingMore && hasMoreOlder)
          _buildLoadMoreIndicator(),
        Expanded(
          child: ScrollablePositionedList.builder(
            key: ValueKey('messages_list_${widget.chatId}'),
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: messages.length,
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            itemBuilder: (context, index) {
              final message = messages[index];
              final showDate = _shouldShowDate(index, messages);
              final isFirstUnread = firstUnreadIndex != null &&
                  index == firstUnreadIndex;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showDate) _buildDateSeparator(message.createdAt),
                  if (isFirstUnread) _buildUnreadIndicator(),
                  MessageBubble(
                    message: message,
                    onReply: () => _replyToMessage(message),
                    onCopyMessage: () => _copyMessage(message),
                    onDeleteMessage: () => _deleteMessage(message),
                    onEditMessage: () => _editMessage(message),
                    onForwardMessage: () => _forwardMessage(message),
                    onSelectMessage: () => _selectMessage(message),
                  ),
                ],
              );
            },
          ),
        ),
        if (isLoadingNewer && hasMoreNewer)
          _buildLoadMoreIndicator(),
      ],
    );
  }

  Widget _buildUnreadIndicator() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 4),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.blue.withOpacity(0.1),
      child: const Center(
        child: Text(
          'Непрочитанные сообщения',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  bool _shouldShowDate(int index, List<MessageEntity> messages) {
    if (index == 0) return true;

    final current = messages[index];
    final previous = messages[index - 1];
    return !_isSameDay(current.createdAt, previous.createdAt);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildLoadMoreIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    );
  }

  Widget _buildDateSeparator(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _formatDate(date),
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Сегодня';
    } else if (messageDate == yesterday) {
      return 'Вчера';
    } else {
      return DateFormat('dd MMMM yyyy').format(date);
    }
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Загрузка сообщений...',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Ошибка загрузки сообщений',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'Выберите чат',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChatState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Нет сообщений',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Text(
            'Начните диалог первым!',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _replyToMessage(MessageEntity message) {
    debugPrint('Reply to: ${message.id}');
    ref.read(messageProvider.notifier).setReplyingMessage(message);

    final focusNode = ref.read(messageInputFocusProvider);
    if (focusNode != null) {
      focusNode.requestFocus();
    }
  }

  void _copyMessage(MessageEntity message) {
    print('Copy message: ${message.id}');
  }

  void _deleteMessage(MessageEntity message) {
    // TODO: Показать диалог подтверждения и удалить
    print('Delete message: ${message.id}');
  }

  void _editMessage(MessageEntity message) {
    // TODO: Открыть диалог редактирования
    print('Edit message: ${message.id}');
  }

  void _forwardMessage(MessageEntity message) {
    // TODO: Открыть выбор чата для пересылки
    print('Forward message: ${message.id}');
  }

  void _selectMessage(MessageEntity message) {
    // TODO: Включить режим выбора сообщений
    print('Select message: ${message.id}');
  }

  Future<void> _handleScrollToSentMessage(String messageId, String messageDate) async {
    if (_isHandlingScrollAction) return;
    _isHandlingScrollAction = true;
    _blockAutoLoad = true;

    try {
      final messageState = ref.read(messageProvider);
      if (messageState is! MessageStateSuccess) return;

      final messages = messageState.messages;
      if (messages.isEmpty) return;

      final bool isLastFiveVisible = _checkIfLastMessagesVisible(5);

      if (isLastFiveVisible) {
        _scrollToBottom();
      } else {
        await ref.read(messageProvider.notifier).jumpToMessage(
          messageId: messageId,
          messageDate: messageDate,
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToMessageById(messageId);
        });
      }
    } finally {
      ref.read(scrollToSentMessageActionProvider.notifier).state = null;
      _isHandlingScrollAction = false;

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _blockAutoLoad = false;
        }
      });
    }
  }

  void _scrollToBottom() {
    final messageState = ref.read(messageProvider);
    if (messageState is! MessageStateSuccess) return;

    final messages = messageState.messages;
    if (messages.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_itemScrollController.isAttached && mounted) {
        _itemScrollController.scrollTo(
          index: messages.length - 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment: 0.7,
        );
      }
    });
  }

  void _scrollToMessageById(String messageId) {
    final messageState = ref.read(messageProvider);
    if (messageState is! MessageStateSuccess) return;

    final messages = messageState.messages;
    final targetIndex = messages.indexWhere((m) => m.id == messageId);

    if (targetIndex != -1 && _itemScrollController.isAttached) {
      _itemScrollController.scrollTo(
        index: targetIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        alignment: 0.3,
      );
    }
  }

  bool _checkIfLastMessagesVisible(int count) {
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return false;

    final messageState = ref.read(messageProvider);
    if (messageState is! MessageStateSuccess) return false;

    final messages = messageState.messages;
    final messagesLength = messages.length;

    if (messagesLength < count) return true;

    final maxVisibleIndex = positions
        .map((pos) => pos.index)
        .reduce((max, index) => index > max ? index : max);

    final lastMessagesStartIndex = messagesLength - count;

    return maxVisibleIndex >= lastMessagesStartIndex;
  }
}