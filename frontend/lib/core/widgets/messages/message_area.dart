part of '../widgets.dart';

class MessageArea extends ConsumerWidget {
  final ScrollController scrollController;

  const MessageArea({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChat = ref.watch(selectedChatProvider);

    if (selectedChat == null) {
      return _buildEmptyState(context);
    }

    return Expanded(
      child: Column(
        children: [
          ChatHeader(chat: selectedChat),
          Expanded(
            child: MessagesList(
              chatId: selectedChat.id,
              scrollController: scrollController,
            ),
          ),
          MessageInput(
            chatId: selectedChat.id,
            receiverId: selectedChat.id,
            onMessageSent: (newMessage) => _handleNewMessage(newMessage, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Center(
        child: Text(
          'Выберите чат для начала общения',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  void _handleNewMessage(DirectMessageModel newMessage, WidgetRef ref) {
    final chatId = newMessage.receiverId;
    ref.read(chatMessagesProvider(chatId).notifier).update((messages) {
      return [...messages, newMessage];
    });
  }
}