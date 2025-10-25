part of '../widgets.dart';

class UserPanel extends ConsumerWidget {
  const UserPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colorScheme.outline)),
      ),
      child: Row(
        children: [
          _buildUserMenu(ref, context),
        ],
      ),
    );
  }

  Widget _buildUserMenu(WidgetRef ref, BuildContext context) {
    return PopupMenuButton<String>(
      icon: CircleAvatar(
        backgroundImage: AssetImage('assets/default-avatar.png'),
      ),
      onSelected: (value) => _onMenuItemSelected(value, ref, context),
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: 'profile',
          child: Text('Профиль'),
        ),
        PopupMenuItem(
          value: 'logout',
          child: Text('Выйти'),
        ),
      ],
    );
  }

  void _onMenuItemSelected(String value, WidgetRef ref, BuildContext context) {
    switch (value) {
      case 'profile':
        context.push('/profile');
        break;
      case 'logout':
        ref.read(authNotifierProvider.notifier).logout();
        break;
    }
  }
}