part of '../widgets/widgets.dart';


class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  int _currentIndex = 0;
  bool _isMobileLayout = false;

  @override
  void initState() {
    super.initState();
    _isMobileLayout = PlatformUtils.isMobile;
  }

  void _showChatList() {
    if (!_isMobileLayout) return;
    setState(() {
      _currentIndex = 0;
    });
  }

  void _showMessageArea(DirectChatEntity chat) {
    if (!_isMobileLayout) return;
    setState(() {
      _currentIndex = 1;
    });
    ref.read(selectedChatProvider.notifier).state = chat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isMobileLayout
          ? _buildMobileLayout()
          : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        const ChatList(),
        Expanded(
          child: Consumer(
            builder: (context, ref, _) {
              final selectedChat = ref.watch(selectedChatProvider);
              if (selectedChat == null) {
                return _buildEmptyState(context);
              }
              return MessageArea(
                chat: selectedChat,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: ChatList(
            onChatSelected: (chat) => _showMessageArea(chat),
          ),
        ).animate(
          target: _currentIndex == 0 ? 1 : 0,
        ).slideX(
          begin: -0.3,
          end: 0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        ).fadeIn(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),

        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Consumer(
            builder: (context, ref, _) {
              final selectedChat = ref.watch(selectedChatProvider);
              if (selectedChat == null) {
                return const SizedBox.shrink();
              }
              return MessageArea(
                chat: selectedChat,
                onBackPressed: _showChatList,
              );
            },
          ),
        ).animate(
          target: _currentIndex == 1 ? 1 : 0,
        ).slideX(
          begin: 0.3,
          end: 0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        ).fadeIn(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: theme.colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'Выберите чат для начала общения',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}