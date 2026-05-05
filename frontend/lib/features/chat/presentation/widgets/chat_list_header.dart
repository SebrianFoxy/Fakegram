part of '../widgets/widgets.dart';

class ChatListHeader extends StatelessWidget {
  const ChatListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMobile = PlatformUtils.isMobile;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(bottom: BorderSide(color: colorScheme.outline)),
      ),
      child: Row(
        children: [
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            )
          else
            Text(
              'Чаты',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          const Spacer(),
          IconButton(
            icon: Icon(
              Icons.search,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
          if (!isMobile) ...[
            const SizedBox(width: 8),
            IconButton(
              icon: Icon(
                Icons.edit,
                color: colorScheme.onSurface.withOpacity(0.6),
              ),
              onPressed: () {

              },
            ),
          ],
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showSearch(
      context: context,
      delegate: ChatSearchDelegate(),
    );
  }
}

class ChatSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(child: Text('Результаты поиска'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Введите имя пользователя'));
  }
}