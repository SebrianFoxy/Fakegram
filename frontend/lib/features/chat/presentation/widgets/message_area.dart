part of '../widgets/widgets.dart';

class MessageArea extends ConsumerWidget {
  const MessageArea({
    super.key,
    required this.chat,
    this.onBackPressed,
  });

  final DirectChatEntity chat;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = PlatformUtils.isMobile;

    if (isMobile) {
      return Column(
        children: [
          ChatHeader(
            chat: chat,
            showBackButton: true,
            onBackPressed: onBackPressed,
          ),
          Expanded(
            child: MessagesList(
              chatId: chat.id,
            ),
          ),
          MessageInput(
            chatId: chat.id,
            receiverId: chat.id,
            onMessageSent: (newMessage) => _handleNewMessage(newMessage, ref),
          ),
        ],
      );
    }

    return Container(
      child: Column(
        children: [
          ChatHeader(
            chat: chat,
            showBackButton: false,
          ),
          Expanded(
            child: MessagesList(
              chatId: chat.id,
            ),
          ),
          MessageInput(
            chatId: chat.id,
            receiverId: chat.id,
            onMessageSent: (newMessage) => _handleNewMessage(newMessage, ref),
          ),
        ],
      ),
    );
  }

  void _handleNewMessage(MessageEntity newMessage, WidgetRef ref) {
    final chatId = newMessage.senderId;
    ref.read(chatMessagesProvider(chatId).notifier).update((messages) {
      return [...messages, newMessage];
    });
  }
}