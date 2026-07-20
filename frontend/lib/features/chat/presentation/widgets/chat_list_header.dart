part of '../widgets/widgets.dart';

class ChatListHeader extends StatefulWidget {
  const ChatListHeader({
    super.key,
    required this.onChanged,
    required this.onClear,
    required this.searchController,
  });

  final Function(String query) onChanged;
  final VoidCallback onClear;
  final TextEditingController searchController;

  @override
  State<ChatListHeader> createState() => _ChatListHeaderState();
}

class _ChatListHeaderState extends State<ChatListHeader> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

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
      child: Column(
        children: [
          _buildTitle(theme),
          const SizedBox(height: 10),
          _buildSearchField(colorScheme),
        ],
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Center(
      child: Text(
        'Чаты',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSearchField(ColorScheme colorScheme) {
    return SizedBox(
      height: _SearchFieldConstants.height,
      child: TextField(
        controller: widget.searchController,
        onChanged: _onSearchChanged,
        decoration: _buildSearchInputDecoration(colorScheme),
        style: TextStyle(
          fontSize: _SearchFieldConstants.fontSize,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged(query.trim());
    });
  }

  void _clearSearch() {
    widget.searchController.clear();
    widget.onClear();
  }

  InputDecoration _buildSearchInputDecoration(ColorScheme colorScheme) {
    final borderRadius = BorderRadius.circular(_SearchFieldConstants.borderRadius);

    return InputDecoration(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: _SearchFieldConstants.horizontalPadding,
        vertical: 0,
      ),
      prefixIcon: _buildSearchIcon(colorScheme),
      suffixIcon: _buildClearButton(colorScheme),
      prefixIconConstraints: const BoxConstraints(
        minWidth: _SearchFieldConstants.iconAreaSize,
        minHeight: _SearchFieldConstants.iconAreaSize,
      ),
      suffixIconConstraints: const BoxConstraints(
        minWidth: _SearchFieldConstants.iconAreaSize,
        minHeight: _SearchFieldConstants.iconAreaSize,
      ),
      hintText: _SearchFieldConstants.hintText,
      hintStyle: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.5),
        fontSize: _SearchFieldConstants.fontSize,
      ),
      border: _buildOutlineBorder(borderRadius),
      enabledBorder: _buildOutlineBorder(borderRadius),
      focusedBorder: _buildOutlineBorder(borderRadius),
    );
  }

  Widget _buildClearButton(ColorScheme colorScheme) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: widget.searchController,
      builder: (context, value, child) {
        final isVisible = value.text.isNotEmpty;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: AnimatedScale(
            scale: isVisible ? 1.0 : 0.5,
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              width: 32,
              height: 32,
              child: isVisible
                  ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: colorScheme.onSurface.withOpacity(0.5),
                  size: 18,
                ),
                onPressed: _clearSearch,
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder _buildOutlineBorder(BorderRadius borderRadius) {
    return OutlineInputBorder(
      borderRadius: borderRadius,
    );
  }

  Widget _buildSearchIcon(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(_SearchFieldConstants.iconPadding),
      child: Icon(
        Icons.search,
        color: colorScheme.onSurface.withOpacity(0.5),
        size: _SearchFieldConstants.iconSize,
      ),
    );
  }
}

class _SearchFieldConstants {
  const _SearchFieldConstants._();

  static const double height = 36.0;
  static const double borderRadius = 18.0;
  static const double horizontalPadding = 12.0;
  static const double fontSize = 14.0;
  static const double iconSize = 18.0;
  static const double iconPadding = 8.0;
  static const double iconAreaSize = 32.0;
  static const String hintText = 'Поиск';
}