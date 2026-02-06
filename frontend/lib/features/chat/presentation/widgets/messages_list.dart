part of 'widgets.dart';

class MessagesList extends ConsumerStatefulWidget {
  final String chatId;
  final ScrollController scrollController;

  const MessagesList({
    super.key,
    required this.chatId,
    required this.scrollController,
  });

  @override
  ConsumerState<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends ConsumerState<MessagesList> {
  final _scrollThreshold = 200.0;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;

    final maxScroll = widget.scrollController.position.maxScrollExtent;
    final currentScroll = widget.scrollController.position.pixels;

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _loadMoreMessages();
    }
  }

  Future<void> _loadMoreMessages() async {
    if (_isLoadingMore) return;

    final messageState = ref.read(messageNotifierProvider);
    if (messageState is! MessageStateSuccessLoading ||
        !messageState.hasMoreMessages ||
        messageState.isLoadingMore) {
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    try {
      await ref.read(messageNotifierProvider.notifier).loadMoreMessages();
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(messageNotifierProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          _onScroll();
        }
        return false;
      },
      child: switch (messageState) {
        MessageStateInitial() => _buildEmptyState(),
        MessageStateLoading() => _buildLoadingState(),
        MessageStateSuccessLoading(
        messages: final messages,
        isLoadingMore: final isLoadingMore,
        hasMoreMessages: final hasMoreMessages,
        ) =>
            Column(
              children: [
                if (isLoadingMore && messages.isNotEmpty) _buildLoadMoreIndicator(),
                Expanded(
                  child: _buildMessagesList(
                    messages,
                    ref,
                    hasMoreMessages: hasMoreMessages,
                    isLoadingMore: isLoadingMore,
                  ),
                ),
              ],
            ),
        MessageStateError(error: final error) =>
            _buildErrorState(error.toString()),
        _ => const Center(
          child: CircularProgressIndicator(),
        ),
      },
    );
  }

  Widget _buildMessagesList(
      List<MessageEntity> messages,
      WidgetRef ref, {
        required bool hasMoreMessages,
        required bool isLoadingMore,
      }) {
    if (messages.isEmpty) {
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

    return ListView.builder(
      controller: widget.scrollController,
      reverse: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: messages.length + (hasMoreMessages ? 1 : 0),
      itemBuilder: (context, index) {
        if (hasMoreMessages && index == messages.length) {
          return _buildLoadMoreIndicator();
        }

        final messageIndex = index;
        final message = messages[messageIndex];
        final showDate = _shouldShowDate(messageIndex, messages);

        return Column(
          children: [
            if (showDate) _buildDateSeparator(message.createdAt),
            MessageBubble(
              message: message,
            ),
          ],
        );
      },
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildDateSeparator(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
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
    return Center(
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
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          SizedBox(height: 16),
          Text(
            'Ошибка загрузки сообщений',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey[400],
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
}