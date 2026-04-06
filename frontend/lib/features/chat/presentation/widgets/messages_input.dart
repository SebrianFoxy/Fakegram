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
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _cancelReply() {
    ref.read(messageProvider.notifier).clearReplyingMessage();
  }

  @override
  Widget build(BuildContext context) {
    final messageState = ref.watch(messageProvider);
    final replyingToMessage = messageState is MessageStateSuccess
        ? messageState.replyingToMessage
        : null;

    return Column(
      children: [
        AnimatedSwitcher(
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
          child: replyingToMessage != null
              ? _ReplyPreview(
            key: const ValueKey('reply_preview'),
            message: replyingToMessage,
            onCancel: _cancelReply,
          )
              : const SizedBox.shrink(),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: const InputDecoration(
                    hintText: 'Сообщение...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                  textInputAction: TextInputAction.send,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  _sendMessage();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _sendMessage() async {
    final userText = _controller.text.trim();
    final messageState = ref.read(messageProvider);
    final replyingTo = messageState is MessageStateSuccess
        ? messageState.replyingToMessage
        : null;

    if (userText.isEmpty || _isSending) {
      return;
    }

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
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
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
                    Icon(
                      Icons.reply,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Ответ для @${message.senderNickname}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message.messageText,
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