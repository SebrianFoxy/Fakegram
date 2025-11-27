part of '../widgets.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatNotifierProvider);
    final selectedChat = ref.watch(selectedChatProvider);
    final isWebSocketConnected = ref.watch(webSocketNotifierProvider);

    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Theme.of(context).colorScheme.outline)),
      ),
      child: Column(
        children: [
          const ChatListHeader(),
          const SizedBox(width: 8),
          Text(
            isWebSocketConnected ? 'Online' : 'Offline',
            style: TextStyle(
              color: isWebSocketConnected ? Colors.green : Colors.red,
            ),
          ),
          Expanded(
            child: switch (chatState) {
              ChatStateSuccessLoading(:final chats) => ListView.builder(
                itemCount: chats.chats.length,
                itemBuilder: (context, index) {
                  final chat = chats.chats[index];
                  return ChatListItem(
                    chat: chat,
                    isSelected: selectedChat?.id == chat.id,
                    onTap: () => ref.read(selectedChatProvider.notifier).state = chat,
                  );
                },
              ),
              ChatStateInitial() => Text("У вас нет чатов!"),
              _ => const Center(
                child: CircularProgressIndicator(),
              )
            },
          ),
          const UserPanel(),
        ],
      ),
    );
  }
}


