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
    return GestureDetector(
      onSecondaryTapDown: (details) {
        _showContextMenu(context, details.globalPosition);
      },
      onLongPressDown: context.isMobile
          ? (details) {
        _showContextMenu(context, details.globalPosition);
      } : null,
      child: child,
    );
  }

  void _showContextMenu(BuildContext context, Offset position) {
    final entries = <ContextMenuEntry>[];

    if (onCopy != null) {
      entries.add(
        MenuItem(
          label: const Text('Копировать'),
          icon: const Icon(Icons.copy_rounded),
          onSelected: (_) => onCopy?.call(),
        ),
      );
    }

    if (onReply != null) {
      entries.add(
        MenuItem(
          label: const Text('Ответить'),
          icon: const Icon(Icons.reply_rounded),
          onSelected: (_) => onReply?.call(),
        ),
      );
    }

    if (onForward != null) {
      entries.add(
        MenuItem(
          label: const Text('Переслать'),
          icon: const Icon(Icons.forward_rounded),
          onSelected: (_) => onForward?.call(),
        ),
      );
    }

    if (onSelect != null) {
      entries.add(
        MenuItem(
          label: const Text('Выбрать'),
          icon: const Icon(Icons.select_all_rounded),
          onSelected: (_) => onSelect?.call(),
        ),
      );
    }

    if (onEdit != null && isSentByMe) {
      entries.add(
        MenuItem(
          label: const Text('Редактировать'),
          icon: const Icon(Icons.edit_rounded),
          onSelected: (_) => onEdit?.call(),
        ),
      );
    }

    if (onDelete != null) {
      entries.add(
        MenuItem(
          label: const Text('Удалить'),
          icon: const Icon(Icons.delete_rounded),
          onSelected: (_) => onDelete?.call(),
        ),
      );
    }

    if (entries.isNotEmpty) {
      ContextMenu(
        entries: entries,
        position: position,
      ).show(context);
    }
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