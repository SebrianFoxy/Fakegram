part of '../widgets.dart';

class ChatListHeader extends StatelessWidget {
  const ChatListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
      ),
      child: Row(
        children: [
          Text(
            'Чаты',
            style: theme.textTheme.titleLarge,
          ),
          const Spacer(),
          _buildIconButton(Icons.search, colorScheme),
          const SizedBox(width: 16),
          _buildIconButton(Icons.more_vert, colorScheme),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, ColorScheme colorScheme) {
    return Icon(
      icon,
      color: colorScheme.onSurface.withOpacity(0.6),
    );
  }
}