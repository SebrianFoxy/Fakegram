part of 'widgets.dart';

class MessageBubble extends ConsumerWidget {
  final MessageEntity message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MessageBubbleView(
      message: message,
      presenter: MessageBubblePresenter(),
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
    final viewModel = presenter.createViewModel(message, context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSenderName(theme, viewModel),
            _buildMessageBubble(context, theme, viewModel),
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
      ) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: viewModel.borderRadius,
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.messageText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              viewModel.formattedTime,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubblePresenter {
  MessageBubbleViewModel createViewModel(
      MessageEntity message,
      BuildContext context,
      ) {
    return MessageBubbleViewModel(
      displayName: _truncateSenderName(message.senderName),
      formattedTime: _formatTime(message.createdAt),
      borderRadius: _getBorderRadius(false),
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
    return const BorderRadius.only(
      topLeft: Radius.circular(4),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );
  }
}

class MessageBubbleViewModel {
  final String displayName;
  final String formattedTime;
  final BorderRadius borderRadius;

  MessageBubbleViewModel({
    required this.displayName,
    required this.formattedTime,
    required this.borderRadius,
  });
}