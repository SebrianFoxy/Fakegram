part of 'widgets.dart';

class MessageBubble extends ConsumerWidget {
  final MessageEntity message;
  final VoidCallback? onReply;
  final VoidCallback? onCopyMessage;
  final VoidCallback? onDeleteMessage;
  final VoidCallback? onEditMessage;
  final VoidCallback? onForwardMessage;
  final VoidCallback? onSelectMessage;

  const MessageBubble({
    super.key,
    required this.message,
    this.onReply,
    this.onCopyMessage,
    this.onDeleteMessage,
    this.onEditMessage,
    this.onForwardMessage,
    this.onSelectMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(currentUserIdProvider);
    final isSentByMe = message.senderId == currentUserId.toString();

    final bubbleView = MessageBubbleView(
      message: message,
      presenter: MessageBubblePresenter(currentUserId: currentUserId.toString()),
    );

    return bubbleView.withMessageContextMenu(
      message: message,
      isSentByMe: isSentByMe,
      onCopy: onCopyMessage,
      onReply: onReply,
      onForward: onForwardMessage,
      onDelete: onDeleteMessage,
      onEdit: onEditMessage,
      onSelect: onSelectMessage,
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
            if (!isSentByMe && !message.isDeleted) _buildSenderName(theme, viewModel),
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
    return IntrinsicWidth(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isDeleted
              ? (isSentByMe
              ? theme.colorScheme.primary.withOpacity(0.4)
              : theme.colorScheme.surface.withOpacity(0.6))
              : (isSentByMe
              ? theme.colorScheme.primary
              : theme.colorScheme.surface),
          borderRadius: viewModel.borderRadius,
          border: Border.all(
            color: isSentByMe
                ? Colors.transparent
                : theme.colorScheme.outline.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: isSentByMe && !message.isDeleted
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
          mainAxisSize: MainAxisSize.min,
          children: [
            if (message.replyToMessage != null) ...[
              _buildReplyPreview(context, theme, isSentByMe),
              const SizedBox(height: 8),
            ],
            if (message.isDeleted)
              Text(
                'Сообщение удалено',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: isSentByMe
                      ? theme.colorScheme.onPrimary.withOpacity(0.6)
                      : theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              )
            else
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
                if (message.isEdited && !message.isDeleted) ...[
                  _buildEditIndicator(theme, isSentByMe),
                  const SizedBox(width: 4),
                ],
                Text(
                  viewModel.formattedTime,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isSentByMe
                        ? theme.colorScheme.onPrimary.withOpacity(message.isDeleted ? 0.5 : 0.8)
                        : theme.colorScheme.onSurface.withOpacity(message.isDeleted ? 0.4 : 0.5),
                  ),
                ),
                if (isSentByMe && !message.isDeleted) ...[
                  const SizedBox(width: 4),
                  _buildStatusIndicator(viewModel.status),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditIndicator(ThemeData theme, bool isSentByMe) {
    return Text(
      '(ред.)',
      style: theme.textTheme.labelSmall?.copyWith(
        fontSize: 10,
        fontStyle: FontStyle.italic,
        color: isSentByMe
            ? theme.colorScheme.onPrimary.withOpacity(0.6)
            : theme.colorScheme.onSurface.withOpacity(0.4),
      ),
    );
  }

  Widget _buildReplyPreview(BuildContext context, ThemeData theme, bool isSentByMe) {
    final replyMessage = message.replyToMessage!;
    final isReplyingToSelf = replyMessage.senderId == message.senderId;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSentByMe
            ? Colors.blueAccent
            : Colors.black12,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: isSentByMe
                ? theme.colorScheme.onPrimary.withOpacity(0.5)
                : Colors.grey.withOpacity(0.7),
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (replyMessage.isDeleted)
            Text(
              'Сообщение удалено',
              style: theme.textTheme.labelSmall?.copyWith(
                fontStyle: FontStyle.italic,
                color: isSentByMe
                    ? theme.colorScheme.onPrimary.withOpacity(0.6)
                    : theme.colorScheme.onSurface.withOpacity(0.5),
              ),
            )
          else ...[
            Text(
              isReplyingToSelf ? 'You' : replyMessage.senderName,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isSentByMe
                    ? theme.colorScheme.onPrimary.withOpacity(0.9)
                    : theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              replyMessage.messageText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSentByMe
                    ? theme.colorScheme.onPrimary.withOpacity(0.8)
                    : theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
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