part of '../widgets/widgets.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({
    super.key,
    this.onChatSelected,
  });

  final Function(DirectChatEntity)? onChatSelected;

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  bool _isSearchMode = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    final selectedChat = ref.watch(selectedChatProvider);
    final isWebSocketConnected = ref.watch(isWebSocketConnectedProvider);
    final isMobile = PlatformUtils.isMobile;

    final content = Column(
      children: [
        ChatListHeader(
          onChanged: _onSearchChanged,
          onClear: _clearSearch,
          searchController: _searchController,
        ),
        _buildConnectionStatus(isWebSocketConnected),
        Expanded(
          child: _buildContent(chatState, selectedChat),
        ),
        if (!_isSearchMode) const UserPanel(),
      ],
    );

    final padding = isMobile
        ? const EdgeInsets.all(8)
        : const EdgeInsets.all(8);

    return Padding(
      padding: padding,
      child: _buildGlassContainer(
        context,
        width: isMobile ? null : 300,
        borderRadius: BorderRadius.circular(24),
        child: content,
      ),
    );
  }

  Widget _buildContent(ChatState state, DirectChatEntity? selectedChat) {
    return switch (state) {
      ChatStateInitial() => const SizedBox.shrink(),
      ChatStateLoading() => const Center(child: CircularProgressIndicator()),
      ChatStateSuccessLoading(:final chats, :final error) =>
          _buildChatList(chats, selectedChat, error),
      ChatStateError(:final error) =>
          Center(child: Text('Ошибка: $error')),
      ChatStateSearchSuccess(:final chats) =>
          _buildSearchResults(chats, selectedChat),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildChatList(
      List<DirectChatEntity> chats,
      DirectChatEntity? selectedChat,
      String? error,
      ) {
    if (chats.isEmpty) {
      return Center(
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
              error ?? "У вас нет чатов",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatListItem(
          chat: chat,
          isSelected: selectedChat?.id == chat.id,
          onTap: () => _onChatTap(chat),
        );
      },
    );
  }

  Widget _buildSearchResults(
      List<DirectChatEntity> chats,
      DirectChatEntity? selectedChat,
      ) {
    if (chats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
            const SizedBox(height: 12),
            Text(
              "Ничего не найдено",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return ChatListItem(
          chat: chat,
          isSelected: selectedChat?.id == chat.id,
          onTap: () => _onChatTap(chat),
        );
      },
    );
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    setState(() => _isSearchMode = query.isNotEmpty);

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty) {
        ref.read(chatProvider.notifier).searchChats(query);
      } else {
        _clearSearch();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _isSearchMode = false);
    ref.read(chatProvider.notifier).clearSearch();
  }

  void _onChatTap(DirectChatEntity chat) {
    if (PlatformUtils.isMobile && widget.onChatSelected != null) {
      widget.onChatSelected!(chat);
    } else {
      ref.read(selectedChatProvider.notifier).state = chat;
    }
    _clearSearch();
  }

  Widget _buildGlassContainer(
      BuildContext context, {
        required Widget child,
        double? width,
        BorderRadius borderRadius = BorderRadius.zero,
      }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface.withOpacity(0.7),
            Theme.of(context).colorScheme.surface.withOpacity(0.4),
            Theme.of(context).colorScheme.surface.withOpacity(0.2),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 0,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.1),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.05),
                  Colors.transparent,
                  Colors.black.withOpacity(0.05),
                ],
              ),
            ),
            child: Stack(
              children: [
                child,
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
              boxShadow: [
                BoxShadow(
                  color: (isConnected ? Colors.green : Colors.red)
                      .withOpacity(0.3),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
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
}