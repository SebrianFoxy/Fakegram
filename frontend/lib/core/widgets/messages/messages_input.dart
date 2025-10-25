part of '../widgets.dart';

// lib/presentation/features/chat/widgets/message/message_input.dart
class MessageInput extends ConsumerStatefulWidget {
  final String chatId;
  final String receiverId;
  final ValueChanged<DirectMessageModel>? onMessageSent;

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
              onSubmitted: (_) => _sendMessage(),
              textInputAction: TextInputAction.send,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // ВРЕМЕННАЯ ЗАГЛУШКА - создаем сообщение локально
    final newMessage = DirectMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: 'current_user', // Заглушка ID текущего пользователя
      receiverId: widget.receiverId, // Используем переданный receiverId
      text: text,
      createdAt: DateTime.now(),
      isRead: true,
      isDelivered: true,
    );

    _controller.clear();

    _focusNode.requestFocus();

    widget.onMessageSent?.call(newMessage);


    // Закомментированная реальная логика:
    /*
    final repository = ref.read(messageRepositoryProvider);

    final messageDto = CreateMessageDto(
      chatId: widget.chatId,
      text: text,
    );

    repository.sendMessage(messageDto).then((_) {
      _controller.clear();
      _focusNode.requestFocus();
    });
    */
  }
}