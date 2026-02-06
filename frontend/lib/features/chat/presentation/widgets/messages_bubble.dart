part of 'widgets.dart';

class MessageBubble extends ConsumerWidget {
  final MessageEntity message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(currentUserIdProvider).value;

    return MessageBubbleView(
      message: message,
      presenter: MessageBubblePresenter(currentUserId: currentUserId.toString()),
    );
  }
}

class MessageBubbleView extends StatelessWidget {
  final MessageEntity message;
  final MessageBubblePresenter presenter;

  const MessageBubbleView({
    super.key,
    required this.message,
    required this.presenter,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSentByMe = presenter.isSentByMe(message);
    final viewModel = presenter.createViewModel(message, context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isSentByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!isSentByMe) _buildSenderName(theme, viewModel),
            _buildMessageBubble(context, theme, viewModel, isSentByMe),
          ],
        ),
      ),
    );
  }

  Widget _buildSenderName(ThemeData theme, MessageBubbleViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(
        viewModel.displayName,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.7),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
      BuildContext context,
      ThemeData theme,
      MessageBubbleViewModel viewModel,
      bool isSentByMe,
      ) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSentByMe
            ? theme.colorScheme.primary
            : theme.colorScheme.surface,
        borderRadius: viewModel.borderRadius,
        border: Border.all(
          color: isSentByMe
              ? Colors.transparent
              : theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: isSentByMe
            ? [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.messageText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSentByMe
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                viewModel.formattedTime,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isSentByMe
                      ? theme.colorScheme.onPrimary.withOpacity(0.8)
                      : theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              if (isSentByMe) ...[
                const SizedBox(width: 4),
                _buildStatusIndicator(viewModel.status),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(MessageStatus status) {
    switch (status) {
      case MessageStatus.sending:
        return SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withOpacity(0.7),
            ),
          ),
        );
      case MessageStatus.sent:
        return Icon(
          Icons.check,
          size: 12,
          color: Colors.white.withOpacity(0.7),
        );
      case MessageStatus.read:
        return Icon(
          Icons.done_all,
          size: 12,
          color: Colors.blue[200]!,
        );
      case MessageStatus.error:
        return Icon(
          Icons.error_outline,
          size: 12,
          color: Colors.red[300]!,
        );
      case MessageStatus.none:
        return Icon(
          Icons.error_outline,
          size: 12,
          color: Colors.red[300]!,
        );
    }
  }
}

class MessageBubblePresenter {
  final String currentUserId;

  MessageBubblePresenter({required this.currentUserId});

  bool isSentByMe(MessageEntity message) {
    return message.senderId == currentUserId;
  }

  MessageBubbleViewModel createViewModel(
      MessageEntity message,
      BuildContext context,
      ) {
    final sentByMe = isSentByMe(message);

    return MessageBubbleViewModel(
      displayName: _truncateSenderName(message.senderName),
      formattedTime: _formatTime(message.createdAt),
      borderRadius: _getBorderRadius(sentByMe),
      status: message.status,
    );
  }

  String _truncateSenderName(String name) {
    const maxLength = 15;
    return name.length > maxLength ? '${name.substring(0, maxLength)}...' : name;
  }

  String _formatTime(DateTime timestamp) {
    return DateFormat.Hm().format(timestamp);
  }

  BorderRadius _getBorderRadius(bool isSentByMe) {
    if (isSentByMe) {
      return const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(4),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      );
    }
  }
}

class MessageBubbleViewModel {
  final String displayName;
  final String formattedTime;
  final BorderRadius borderRadius;
  final MessageStatus status;

  MessageBubbleViewModel({
    required this.displayName,
    required this.formattedTime,
    required this.borderRadius,
    required this.status,
  });
}