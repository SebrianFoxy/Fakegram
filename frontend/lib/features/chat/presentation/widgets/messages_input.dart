part of 'widgets.dart';

class MessageInput extends ConsumerStatefulWidget {
  final String chatId;
  final String receiverId;
  final ValueChanged<MessageEntity>? onMessageSent;

  const MessageInput({
    super.key,
    required this.chatId,
    required this.receiverId,
    this.onMessageSent,
  });

  @override
  ConsumerState<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends ConsumerState<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messageInputFocusProvider.notifier).state = _focusNode;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _cancelReply() {
    ref.read(messageProvider.notifier).clearReplyingMessage();
  }

  void _cancelEdit() {
    ref.read(messageProvider.notifier).clearEditMessage();
    _controller.clear();
  }

  ({MessageEntity? editingMessage, MessageEntity? replyingMessage, bool isEditMode, bool isReplyMode}) _getInputData() {
    final messageState = ref.watch(messageProvider);

    if (messageState is! MessageStateSuccess) {
      return (editingMessage: null, replyingMessage: null, isEditMode: false, isReplyMode: false);
    }

    final editingMessage = messageState.editingMessage;
    final replyingMessage = messageState.replyingToMessage;
    final isEditMode = editingMessage != null;
    final isReplyMode = replyingMessage != null && !isEditMode;

    return (
    editingMessage: editingMessage,
    replyingMessage: replyingMessage,
    isEditMode: isEditMode,
    isReplyMode: isReplyMode,
    );
  }

  void _syncTextIfEditing(MessageEntity? editingMessage) {
    if (editingMessage == null) return;
    if (_controller.text == editingMessage.messageText) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.text = editingMessage.messageText;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: editingMessage.messageText.length),
      );
    });
  }

  String _getHintText(bool isEditMode) {
    return isEditMode ? 'Редактировать сообщение...' : 'Сообщение...';
  }

  Future<void> _handleSubmit(bool isEditMode) async {
    if (isEditMode) {
      await _saveEditedMessage();
    } else {
      await _sendMessage();
    }
  }

  Widget _buildPreview({
    required bool isEditMode,
    required bool isReplyMode,
    required MessageEntity? editingMessage,
    required MessageEntity? replyingMessage,
  }) {
    final Widget? targetChild;

    if (isEditMode && editingMessage != null) {
      targetChild = _EditPreview(
        key: const ValueKey('edit_preview'),
        message: editingMessage,
        onCancel: _cancelEdit,
      );
    } else if (isReplyMode && replyingMessage != null) {
      targetChild = _ReplyPreview(
        key: const ValueKey('reply_preview'),
        message: replyingMessage,
        onCancel: _cancelReply,
      );
    } else {
      targetChild = null;
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          ),
        );
      },
      child: targetChild ?? const SizedBox.shrink(),
    );
  }

  Widget _buildSendButton(bool isEditMode) {
    return IconButton(
      icon: Icon(isEditMode ? Icons.check : Icons.send),
      onPressed: () => _handleSubmit(isEditMode),
    );
  }

  Widget _buildInputField(bool isEditMode) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: _getHintText(isEditMode),
                border: const OutlineInputBorder(),
                prefixIcon: isEditMode ? const Icon(Icons.edit, size: 20) : null,
              ),
              onSubmitted: (_) => _handleSubmit(isEditMode),
              textInputAction: TextInputAction.send,
            ),
          ),
          const SizedBox(width: 8),
          _buildSendButton(isEditMode),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (:editingMessage, :replyingMessage, :isEditMode, :isReplyMode) = _getInputData();

    _syncTextIfEditing(editingMessage);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPreview(
          isEditMode: isEditMode,
          isReplyMode: isReplyMode,
          editingMessage: editingMessage,
          replyingMessage: replyingMessage,
        ),
        _buildInputField(isEditMode),
      ],
    );
  }

  Future<void> _sendMessage() async {
    final userText = _controller.text.trim();
    final messageState = ref.read(messageProvider);
    final replyingTo = messageState is MessageStateSuccess ? messageState.replyingToMessage : null;

    if (userText.isEmpty || _isSending) return;

    try {
      _isSending = true;
      _controller.clear();

      await ref.read(messageProvider.notifier).sendMessage(
        messageText: userText,
        messageType: 'text',
        replyToMessageId: replyingTo?.id,
        replyToMessage: replyingTo,
      );

      _focusNode.requestFocus();
    } catch (error) {
      _controller.text = userText;
    } finally {
      _isSending = false;
    }
  }

  Future<void> _saveEditedMessage() async {
    final newText = _controller.text.trim();
    final messageState = ref.read(messageProvider);
    final editingMessage = messageState is MessageStateSuccess ? messageState.editingMessage : null;

    if (newText.isEmpty || _isSending || editingMessage == null) return;
    if (newText == editingMessage.messageText) {
      _cancelEdit();
      return;
    }

    try {
      _isSending = true;

      await ref.read(messageProvider.notifier).editMessage(
        messageId: editingMessage.id,
        newMessageText: newText,
      );

      _controller.clear();
      _cancelEdit();
      _focusNode.requestFocus();
    } catch (error) {
      debugPrint('❌ Failed to save edited message: $error');
    } finally {
      _isSending = false;
    }
  }
}

class _PreviewContainer extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final IconData icon;
  final String title;
  final String messageText;
  final VoidCallback onCancel;

  const _PreviewContainer({
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.title,
    required this.messageText,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 16, color: borderColor),
                    const SizedBox(width: 4),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: borderColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  messageText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 18,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            onPressed: onCancel,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}

class _ReplyPreview extends StatelessWidget {
  final MessageEntity message;
  final VoidCallback onCancel;

  const _ReplyPreview({
    super.key,
    required this.message,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return _PreviewContainer(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      icon: Icons.reply,
      title: 'Ответ для @${message.senderNickname}',
      messageText: message.messageText,
      onCancel: onCancel,
    );
  }
}

class _EditPreview extends StatelessWidget {
  final MessageEntity message;
  final VoidCallback onCancel;

  const _EditPreview({
    super.key,
    required this.message,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return _PreviewContainer(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      icon: Icons.edit,
      title: 'Редактирование',
      messageText: message.messageText,
      onCancel: onCancel,
    );
  }
}