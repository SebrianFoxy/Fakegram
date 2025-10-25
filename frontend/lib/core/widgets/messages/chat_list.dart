part of '../widgets.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatListProvider);
    final selectedChat = ref.watch(selectedChatProvider);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Theme.of(context).colorScheme.outline)),
      ),
      child: Column(
        children: [
          const ChatListHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatListItem(
                  chat: chat,
                  isSelected: selectedChat?.id == chat.id,
                  onTap: () => ref.read(selectedChatProvider.notifier).state = chat,
                );
              },
            ),
          ),
          const UserPanel(),
        ],
      ),
    );
  }
}


