part of '../widgets.dart';

class ChatHeader extends ConsumerWidget {
  final DirectChatModel chat;

  const ChatHeader({super.key, required this.chat});

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
          radius: 20,
          backgroundImage: AssetImage(chat.otherUserAvatar),
        ),
        if (chat.isOnline) _buildOnlineIndicator(theme),
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
            chat.otherUserName,
            style: theme.textTheme.titleLarge,
          ),
          Text(
            chat.isOnline ? 'в сети' : 'был(а) недавно',
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