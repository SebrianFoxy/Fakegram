part of '../widgets.dart';

class MessageBubble extends ConsumerWidget {
  final DirectMessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isSentByMe = true;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSentByMe
                ? theme.colorScheme.primary
                : theme.colorScheme.surface,
            borderRadius: _getBorderRadius(isSentByMe),
          ),
          child: Text(
            message.text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSentByMe
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius(bool isSentByMe) {
    return BorderRadius.only(
      topLeft: const Radius.circular(16),
      topRight: const Radius.circular(16),
      bottomLeft: isSentByMe ? const Radius.circular(16) : const Radius.circular(4),
      bottomRight: isSentByMe ? const Radius.circular(4) : const Radius.circular(16),
    );
  }
}