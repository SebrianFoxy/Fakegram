part of '../widgets.dart';

class MessagesList extends ConsumerWidget {
  final String chatId;
  final ScrollController scrollController;

  const MessagesList({
    super.key,
    required this.chatId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatMessagesProvider(chatId));

    return ListView.builder(
      controller: scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return MessageBubble(message: message);
      },
    );
  }
}