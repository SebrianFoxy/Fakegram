part of 'widgets.dart';

class GroupChatData {
  final String title;
  final List<String> memberIds;

  const GroupChatData({
    required this.title,
    required this.memberIds,
  });
}

class CreateGroupChatForm extends ConsumerStatefulWidget {
  final VoidCallback onClose;
  final ValueChanged<GroupChatData> onCreate;

  const CreateGroupChatForm({
    super.key,
    required this.onClose,
    required this.onCreate,
  });

  @override
  ConsumerState<CreateGroupChatForm> createState() =>
      _CreateGroupChatFormState();
}

class _CreateGroupChatFormState
    extends ConsumerState<CreateGroupChatForm> {
  final TextEditingController _titleController = TextEditingController();

  final List<String> _selectedMemberIds = [];

  bool get _canCreate =>
      _titleController.text.trim().isNotEmpty &&
          _selectedMemberIds.isNotEmpty;

  List<DirectChatEntity> get _privateChats {
    final chatState = ref.watch(chatProvider);

    return switch (chatState) {
      ChatStateSuccessLoading(:final chats) => chats.where((chat) {
        return chat.id.startsWith('private') &&
            chat.otherUser != null;
      }).toList(),
      _ => const [],
    };
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onChanged);
  }

  @override
  void dispose() {
    _titleController
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {});
  }

  void _openMembersDialog() {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (context) {
        return _MembersDialog(
          chats: _privateChats,
          selectedMemberIds: _selectedMemberIds,
          onChanged: (ids) {
            setState(() {
              _selectedMemberIds
                ..clear()
                ..addAll(ids);
            });
          },
        );
      },
    );
  }

  void _createGroup() {
    if (!_canCreate) return;

    widget.onCreate(
      GroupChatData(
        title: _titleController.text.trim(),
        memberIds: List<String>.from(_selectedMemberIds),
      ),
    );
  }

  String _displayName(DirectChatEntity chat) {
    final user = chat.otherUser;

    if (user == null) {
      return chat.title;
    }

    final fullName = [
      user.name.trim(),
      user.surname.trim(),
    ].where((e) => e.isNotEmpty).join(' ');

    if (fullName.isNotEmpty) {
      return fullName;
    }

    if (user.nickname.trim().isNotEmpty) {
      return '@${user.nickname.trim()}';
    }

    return chat.title;
  }

  Widget _buildGlassButton({
    required VoidCallback? onPressed,
    required Widget child,
    required ColorScheme colors,
    double size = 44,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(size / 2),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: colors.surface.withOpacity(0.38),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.12),
                  width: 0.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 16,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassContainer({
    required Widget child,
    required ColorScheme colors,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    final radius = borderRadius ?? BorderRadius.circular(22);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: colors.surface.withOpacity(0.32),
            borderRadius: radius,
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            top: 6,
            bottom: 6,
          ),
          child: _buildGlassButton(
            colors: colors,
            onPressed: widget.onClose,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 19,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 12,
              top: 6,
              bottom: 6,
            ),
            child: _buildGlassButton(
              colors: colors,
              onPressed: _canCreate ? _createGroup : null,
              child: Icon(
                Icons.check_rounded,
                size: 23,
                color: _canCreate
                    ? Colors.white
                    : Colors.white.withOpacity(0.3),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            110,
            20,
            32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: _buildGroupAvatar(colors),
              ),
              const SizedBox(height: 18),
              Text(
                'Создать группу',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onBackground,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Добавьте название и участников',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onBackground.withOpacity(0.52),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 26),
              _buildGlassContainer(
                colors: colors,
                borderRadius: BorderRadius.circular(18),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 2,
                ),
                child: TextField(
                  controller: _titleController,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 16,
                  ),
                  cursorColor: colors.primary,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Название группы',
                    hintStyle: TextStyle(
                      color: colors.onSurface.withOpacity(0.42),
                    ),
                    icon: Icon(
                      Icons.groups_rounded,
                      color: colors.onSurface.withOpacity(0.55),
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _buildMembersSection(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupAvatar(ColorScheme colors) {
    return Container(
      width: 86,
      height: 86,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary.withOpacity(0.9),
            colors.primary.withOpacity(0.45),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.18),
            blurRadius: 28,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Icon(
        Icons.groups_rounded,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  Widget _buildMembersSection(ColorScheme colors) {
    return _buildGlassContainer(
      colors: colors,
      borderRadius: BorderRadius.circular(20),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          InkWell(
            onTap: _openMembersDialog,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary.withOpacity(0.16),
                    ),
                    child: Icon(
                      Icons.person_add_alt_1_rounded,
                      color: colors.primary,
                      size: 21,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Добавить участников',
                          style: TextStyle(
                            color: colors.onSurface,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          _selectedMemberIds.isEmpty
                              ? 'Выберите пользователей'
                              : '${_selectedMemberIds.length} выбрано',
                          style: TextStyle(
                            color: colors.onSurface.withOpacity(0.48),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: colors.onSurface.withOpacity(0.38),
                  ),
                ],
              ),
            ),
          ),
          if (_selectedMemberIds.isNotEmpty) ...[
            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: Colors.white.withOpacity(0.07),
            ),
            _buildSelectedMembers(colors),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedMembers(ColorScheme colors) {
    final selectedChats = _privateChats
        .where(
          (chat) => _selectedMemberIds.contains(chat.otherUser?.id),
    )
        .toList();

    if (selectedChats.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;

          final itemWidth = availableWidth < 300
              ? 54.0
              : availableWidth < 400
              ? 58.0
              : 62.0;

          final avatarSize = availableWidth < 300
              ? 44.0
              : 46.0;

          final fontSize = availableWidth < 300
              ? 9.5
              : 10.0;

          return SizedBox(
            height: avatarSize + 24,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: selectedChats.length,
              separatorBuilder: (_, __) {
                return SizedBox(
                  width: availableWidth < 300 ? 8 : 10,
                );
              },
              itemBuilder: (context, index) {
                final chat = selectedChats[index];

                return GestureDetector(
                  onTap: () {
                    final userId = chat.otherUser?.id;

                    if (userId == null) {
                      return;
                    }

                    setState(() {
                      _selectedMemberIds.remove(userId);
                    });
                  },
                  child: SizedBox(
                    width: itemWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: avatarSize,
                          height: avatarSize,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                width: avatarSize,
                                height: avatarSize,
                                child: _buildSmallAvatar(
                                  chat,
                                  colors,
                                ),
                              ),
                              Positioned(
                                right: -1,
                                top: -1,
                                child: Container(
                                  width: 17,
                                  height: 17,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.surface,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.12),
                                      width: 0.8,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.close_rounded,
                                    size: 11,
                                    color: colors.onSurface.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3),
                        SizedBox(
                          width: itemWidth,
                          child: Text(
                            _displayName(chat),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: colors.onSurface.withOpacity(0.75),
                              fontSize: fontSize,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSmallAvatar(DirectChatEntity chat, ColorScheme colors) {
    final user = chat.otherUser;
    final avatarUrl = user?.avatarUrl;

    if (avatarUrl != null && avatarUrl.trim().isNotEmpty) {
      return ClipOval(
        child: Image.network(
          avatarUrl,
          width: 46,
          height: 46,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return _smallAvatarPlaceholder(chat, colors);
          },
        ),
      );
    }

    return _smallAvatarPlaceholder(chat, colors);
  }

  Widget _smallAvatarPlaceholder(DirectChatEntity chat, ColorScheme colors) {
    final name = _displayName(chat);
    final letter = name.trim().isNotEmpty
        ? name.trim()[0].toUpperCase()
        : '?';

    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.primary.withOpacity(0.65),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _MembersDialog extends StatefulWidget {
  final List<DirectChatEntity> chats;
  final List<String> selectedMemberIds;
  final ValueChanged<List<String>> onChanged;

  const _MembersDialog({
    required this.chats,
    required this.selectedMemberIds,
    required this.onChanged,
  });

  @override
  State<_MembersDialog> createState() => _MembersDialogState();
}

class _MembersDialogState extends State<_MembersDialog> {
  final TextEditingController _searchController =
  TextEditingController();

  late List<String> _selectedIds;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selectedIds = List<String>.from(widget.selectedMemberIds);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _query = _searchController.text.trim().toLowerCase();
    });
  }

  List<DirectChatEntity> get _filteredChats {
    if (_query.isEmpty) {
      return widget.chats;
    }

    return widget.chats.where((chat) {
      final user = chat.otherUser;

      if (user == null) {
        return false;
      }

      final name = user.name.toLowerCase();
      final surname = user.surname.toLowerCase();
      final nickname = user.nickname.toLowerCase();
      final title = chat.title.toLowerCase();

      return name.contains(_query) ||
          surname.contains(_query) ||
          nickname.contains(_query) ||
          title.contains(_query);
    }).toList();
  }

  String _displayName(DirectChatEntity chat) {
    final user = chat.otherUser;

    if (user == null) {
      return chat.title;
    }

    final fullName = [
      user.name.trim(),
      user.surname.trim(),
    ].where((e) => e.isNotEmpty).join(' ');

    if (fullName.isNotEmpty) {
      return fullName;
    }

    if (user.nickname.trim().isNotEmpty) {
      return '@${user.nickname.trim()}';
    }

    return chat.title;
  }

  String _subtitle(DirectChatEntity chat) {
    final nickname = chat.otherUser?.nickname.trim();

    if (nickname != null && nickname.isNotEmpty) {
      return '@$nickname';
    }

    return '';
  }

  void _toggle(DirectChatEntity chat) {
    final userId = chat.otherUser?.id;

    if (userId == null) {
      return;
    }

    setState(() {
      if (_selectedIds.contains(userId)) {
        _selectedIds.remove(userId);
      } else {
        _selectedIds.add(userId);
      }
    });
  }

  void _confirm() {
    widget.onChanged(List<String>.from(_selectedIds));
    Navigator.of(context).pop();
  }

  Widget _buildAvatar(
      DirectChatEntity chat,
      ColorScheme colors,
      ) {
    final user = chat.otherUser;
    final avatarUrl = user?.avatarUrl;

    if (avatarUrl != null && avatarUrl.trim().isNotEmpty) {
      return ClipOval(
        child: Image.network(
          avatarUrl,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return _avatarPlaceholder(chat, colors);
          },
        ),
      );
    }

    return _avatarPlaceholder(chat, colors);
  }

  Widget _avatarPlaceholder(
      DirectChatEntity chat,
      ColorScheme colors,
      ) {
    final name = _displayName(chat);
    final letter = name.trim().isNotEmpty
        ? name.trim()[0].toUpperCase()
        : '?';

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.primary.withOpacity(0.85),
            colors.primary.withOpacity(0.45),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 25,
            sigmaY: 25,
          ),
          child: Container(
            width: 350,
            constraints: const BoxConstraints(
              maxHeight: 430,
            ),
            decoration: BoxDecoration(
              color: colors.surface.withOpacity(0.72),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 40,
                  offset: const Offset(0, 18),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    18,
                    16,
                    12,
                    10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Добавить участников',
                          style: TextStyle(
                            color: colors.onSurface,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.07),
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            size: 19,
                            color: colors.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    14,
                    0,
                    14,
                    10,
                  ),
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.16),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.06),
                      ),
                    ),
                    child: TextField(
                      controller: _searchController,
                      autofocus: false,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 14,
                      ),
                      cursorColor: colors.primary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 20,
                          color: colors.onSurface.withOpacity(0.42),
                        ),
                        hintText: 'Поиск',
                        hintStyle: TextStyle(
                          color: colors.onSurface.withOpacity(0.38),
                          fontSize: 14,
                        ),
                        suffixIcon: _query.isNotEmpty
                            ? IconButton(
                          onPressed: _searchController.clear,
                          icon: Icon(
                            Icons.close_rounded,
                            size: 17,
                            color: colors.onSurface
                                .withOpacity(0.45),
                          ),
                        )
                            : null,
                        contentPadding:
                        const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.white.withOpacity(0.07),
                ),
                Flexible(
                  child: _filteredChats.isEmpty
                      ? Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 42,
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.person_search_rounded,
                          size: 38,
                          color: colors.onSurface
                              .withOpacity(0.25),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.chats.isEmpty
                              ? 'Нет доступных пользователей'
                              : 'Ничего не найдено',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.onSurface
                                .withOpacity(0.48),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    shrinkWrap: true,
                    itemCount: _filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];
                      final userId = chat.otherUser?.id;

                      if (userId == null) {
                        return const SizedBox.shrink();
                      }

                      final selected =
                      _selectedIds.contains(userId);

                      return InkWell(
                        onTap: () => _toggle(chat),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          child: Row(
                            children: [
                              _buildAvatar(chat, colors),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _displayName(chat),
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color:
                                        colors.onSurface,
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w600,
                                      ),
                                    ),
                                    if (_subtitle(chat)
                                        .isNotEmpty)
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(
                                          top: 2,
                                        ),
                                        child: Text(
                                          _subtitle(chat),
                                          maxLines: 1,
                                          overflow: TextOverflow
                                              .ellipsis,
                                          style: TextStyle(
                                            color: colors
                                                .onSurface
                                                .withOpacity(
                                                0.42),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              AnimatedContainer(
                                duration: const Duration(
                                  milliseconds: 160,
                                ),
                                width: 23,
                                height: 23,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selected
                                      ? colors.primary
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: selected
                                        ? colors.primary
                                        : colors.onSurface
                                        .withOpacity(0.25),
                                    width: 1.5,
                                  ),
                                ),
                                child: selected
                                    ? const Icon(
                                  Icons.check_rounded,
                                  size: 16,
                                  color: Colors.white,
                                )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.white.withOpacity(0.07),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: double.infinity,
                    height: 42,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: _selectedIds.isNotEmpty
                            ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colors.primary.withOpacity(0.9),
                            colors.primary.withOpacity(0.55),
                          ],
                        )
                            : null,
                        color: _selectedIds.isEmpty
                            ? colors.onSurface.withOpacity(0.07)
                            : null,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: _selectedIds.isEmpty
                              ? null
                              : _confirm,
                          child: Center(
                            child: Text(
                              _selectedIds.isEmpty
                                  ? 'Выберите участников'
                                  : 'Готово (${_selectedIds.length})',
                              style: TextStyle(
                                color: _selectedIds.isEmpty
                                    ? colors.onSurface
                                    .withOpacity(0.3)
                                    : Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}