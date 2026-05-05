part of '../widgets/widgets.dart';

class ChatList extends ConsumerWidget {
  const ChatList({
    super.key,
    this.onChatSelected,
  });

  final Function(DirectChatEntity)? onChatSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final selectedChat = ref.watch(selectedChatProvider);
    final isWebSocketConnected = ref.watch(isWebSocketConnectedProvider);
    final isMobile = PlatformUtils.isMobile;

    if (isMobile) {
      return SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Column(
            children: [
              const ChatListHeader(),
              _buildConnectionStatus(isWebSocketConnected),
              Expanded(
                child: _buildChatList(context, chatState, selectedChat, ref),
              ),
              const UserPanel(),
            ],
          ),
        ),
      );
    }

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
      child: Column(
        children: [
          const ChatListHeader(),
          _buildConnectionStatus(isWebSocketConnected),
          Expanded(
            child: _buildChatList(context, chatState, selectedChat, ref),
          ),
          const UserPanel(),
        ],
      ),
    );
  }

  Widget _buildConnectionStatus(bool isConnected) {
    final isMobile = PlatformUtils.isMobile;

    if (isMobile) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isConnected ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            isConnected ? 'Соединение установлено' : 'Нет соединения',
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(
      BuildContext context,
      ChatState chatState,
      DirectChatEntity? selectedChat,
      WidgetRef ref,
      ) {
    return switch (chatState) {
      ChatStateSuccessLoading(:final chats) => ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatListItem(
            chat: chat,
            isSelected: selectedChat?.id == chat.id,
            onTap: () {
              if (PlatformUtils.isMobile && onChatSelected != null) {
                onChatSelected!(chat);
              } else {
                ref.read(selectedChatProvider.notifier).state = chat;
              }
            },
          );
        },
      ),
      ChatStateInitial() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 12),
            Text(
              "У вас нет чатов",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
      _ => const Center(
        child: CircularProgressIndicator(),
      ),
    };
  }
}