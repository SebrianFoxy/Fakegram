part of 'widgets.dart';

class MessageContextMenu extends StatelessWidget {
  final Widget child;
  final MessageEntity message;
  final VoidCallback? onCopy;
  final VoidCallback? onReply;
  final VoidCallback? onForward;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onSelect;
  final bool isSentByMe;

  const MessageContextMenu({
    super.key,
    required this.child,
    required this.message,
    required this.isSentByMe,
    this.onCopy,
    this.onReply,
    this.onForward,
    this.onDelete,
    this.onEdit,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ContextMenuWidget(
      child: child,
      menuProvider: (_) => _buildMenu(context),
    );
  }

  Menu _buildMenu(BuildContext context) {
    return Menu(
      children: [
        if (onCopy != null)
          MenuAction(
            title: 'Копировать',
            image: MenuImage.icon(Icons.copy_rounded),
            callback: () => onCopy?.call(),
          ),
        if (onReply != null)
          MenuAction(
            title: 'Ответить',
            image: MenuImage.icon(Icons.reply_rounded),
            callback: () => onReply?.call(),
          ),
        if (onForward != null)
          MenuAction(
            title: 'Переслать',
            image: MenuImage.icon(Icons.forward_rounded),
            callback: () => onForward?.call(),
          ),
        if (onSelect != null)
          MenuAction(
            title: 'Выбрать',
            image: MenuImage.icon(Icons.select_all_rounded),
            callback: () => onSelect?.call(),
          ),
        if (onEdit != null && isSentByMe)
          MenuAction(
            title: 'Редактировать',
            image: MenuImage.icon(Icons.edit_rounded),
            callback: () => onEdit?.call(),
          ),
        if (onDelete != null)
          MenuAction(
            title: 'Удалить',
            image: MenuImage.icon(Icons.delete_rounded),
            attributes: const MenuActionAttributes(destructive: true),
            callback: () => onDelete?.call(),
          ),
      ],
    );
  }
}

extension MessageContextMenuExtension on Widget {
  Widget withMessageContextMenu({
    required MessageEntity message,
    required bool isSentByMe,
    VoidCallback? onCopy,
    VoidCallback? onReply,
    VoidCallback? onForward,
    VoidCallback? onDelete,
    VoidCallback? onEdit,
    VoidCallback? onSelect,
  }) {
    return MessageContextMenu(
      message: message,
      isSentByMe: isSentByMe,
      onCopy: onCopy,
      onReply: onReply,
      onForward: onForward,
      onDelete: onDelete,
      onEdit: onEdit,
      onSelect: onSelect,
      child: this,
    );
  }
}