part of '../widgets.dart';

class ChatListItem extends ConsumerWidget {
  final DirectChatModel chat;
  final bool isSelected;
  final VoidCallback onTap;

  const ChatListItem({
    super.key,
    required this.chat,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      color: isSelected ? colorScheme.secondaryContainer : Colors.transparent,
      child: ListTile(
        leading: _buildAvatar(theme),
        title: _buildTitle(theme),
        subtitle: _buildSubtitle(theme),
        trailing: _buildTrailing(theme),
        onTap: onTap,
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

  Widget _buildTitle(ThemeData theme) {
    final maxLength = 15;
    final displayText = chat.title.length > maxLength
        ? '${chat.title.substring(0, maxLength)}...'
        : chat.title;

    return Text(
      displayText,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _buildSubtitle(ThemeData theme) {
    return Text(
      chat.lastMessage.messageText.toString(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.bodySmall?.copyWith(
        color: isSelected
            ? theme.colorScheme.primary.withOpacity(0.8)
            : theme.colorScheme.onSurface.withOpacity(0.6),
      ),
    );
  }

  Widget _buildTrailing(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildTime(theme),
        if (chat.unreadCount > 0) _buildUnreadCounter(theme),
      ],
    );
  }

  Widget _buildTime(ThemeData theme) {
    return Text(
      DateFormat.Hm().format(chat.lastMessage.createdAt),
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }

  Widget _buildUnreadCounter(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: Text(
        chat.unreadCount.toString(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}