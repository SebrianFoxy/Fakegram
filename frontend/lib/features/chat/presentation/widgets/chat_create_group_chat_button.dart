part of 'widgets.dart';

class _CreateChatButton extends StatelessWidget {
  const _CreateChatButton({
    this.onCreateGroupChat,
    this.onCreatePrivateChat,
    this.onCreateChannel,
  });

  final VoidCallback? onCreateGroupChat;
  final VoidCallback? onCreatePrivateChat;
  final VoidCallback? onCreateChannel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Builder(
      builder: (buttonContext) => IconButton(
        onPressed: () => _showMenu(buttonContext),
        icon: Icon(Icons.edit_outlined, color: colorScheme.primary, size: 22),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        splashRadius: 18,
      ),
    );
  }

  void _showMenu(BuildContext buttonContext) {
    final entries = <ContextMenuEntry>[];

    if (onCreateGroupChat != null) {
      entries.add(_item(
        icon: Icons.group_add_rounded,
        label: 'Создать группу',
        onTap: onCreateGroupChat!,
      ));
    }
    if (onCreatePrivateChat != null) {
      entries.add(_item(
        icon: Icons.person_add_rounded,
        label: 'Личный чат',
        onTap: onCreatePrivateChat!,
      ));
    }
    if (onCreateChannel != null) {
      entries.add(_item(
        icon: Icons.campaign_rounded,
        label: 'Создать канал',
        onTap: onCreateChannel!,
      ));
    }

    if (entries.isEmpty) return;

    final RenderBox button = buttonContext.findRenderObject() as RenderBox;
    final buttonTopRight = button.localToGlobal(
      Offset(button.size.width, button.size.height),
    );

    final position = Offset(
      buttonTopRight.dx,
      buttonTopRight.dy,
    );

    ContextMenu(
      entries: entries,
      position: position,
    ).show(buttonContext);
  }

  MenuItem _item({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return MenuItem(
      label: Text(label, style: const TextStyle(fontSize: 13)),
      icon: Icon(icon, size: 18),
      onSelected: (_) => onTap(),
    );
  }
}