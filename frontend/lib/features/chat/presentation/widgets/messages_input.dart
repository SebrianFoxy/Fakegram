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

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              //onSubmitted: (_) => _sendMessage(),
              textInputAction: TextInputAction.send,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}