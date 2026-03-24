part of 'widgets.dart';

class ChatHeader extends ConsumerWidget {
  final DirectChatEntity chat;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const ChatHeader({
    super.key,
    required this.chat,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
      ),
      child: Row(
        children: [
          if (showBackButton && onBackPressed != null)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          if (showBackButton && onBackPressed != null)
            const SizedBox(width: 8),
          _buildAvatar(theme),
          const SizedBox(width: 12),
          _buildUserInfo(theme),
          const Spacer(),
          _buildMenuButton(colorScheme),
        ],
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: chat.otherUser.avatarUrl != null
              ? NetworkImage(chat.otherUser.avatarUrl!)
              : const AssetImage('assets/default-avatar.png') as ImageProvider,
        ),
        if (chat.otherUser.isOnline) _buildOnlineIndicator(theme),
      ],
    );
  }

  Widget _buildOnlineIndicator(ThemeData theme) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          border: Border.all(color: theme.colorScheme.surface, width: 2),
        ),
      ),
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chat.title.length > (showBackButton ? 12 : 15)
                ? '${chat.title.substring(0, showBackButton ? 12 : 15)}...'
                : chat.title,
            style: theme.textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            chat.otherUser.isOnline ? 'в сети' : 'был(а) недавно',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(ColorScheme colorScheme) {
    return IconButton(
      icon: Icon(Icons.more_vert, color: colorScheme.onSurface.withOpacity(0.6)),
      onPressed: () {},
    );
  }
}