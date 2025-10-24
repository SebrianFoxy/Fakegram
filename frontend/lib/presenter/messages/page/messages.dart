import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../auth/notifier/auth_notifier.dart';

class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
  final int unreadCount;
  final bool isOnline;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    this.unreadCount = 0,
    this.isOnline = false,
  });
}

class MessagesPage extends ConsumerStatefulWidget {
  const MessagesPage({super.key});

  @override
  ConsumerState<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends ConsumerState<MessagesPage> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  List<String> _messages = [];
  Chat? _selectedChat;

  final List<Chat> _chats = [
    Chat(
      id: '1',
      name: 'Анна Петрова',
      lastMessage: 'Привет! Как дела?',
      time: '12:30',
      avatar: 'assets/default-avatar.png',
      unreadCount: 2,
      isOnline: true,
    ),
    Chat(
      id: '2',
      name: 'Иван Сидоров',
      lastMessage: 'Встречаемся в 18:00',
      time: '11:45',
      avatar: 'assets/default-avatar.png',
      unreadCount: 0,
      isOnline: false,
    ),
    Chat(
      id: '3',
      name: 'Мария Иванова',
      lastMessage: 'Отправил документы',
      time: '10:20',
      avatar: 'assets/default-avatar.png',
      unreadCount: 1,
      isOnline: true,
    ),
    Chat(
      id: '4',
      name: 'Рабочая группа',
      lastMessage: 'Алексей: Обновление по проекту',
      time: '09:15',
      avatar: 'assets/default-avatar.png',
      unreadCount: 5,
      isOnline: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (_chats.isNotEmpty) {
      _selectedChat = _chats.first;
      _messages = [
        'Привет!',
        'Как твои дела?',
        'Все отлично, спасибо!',
        'Что нового?',
      ];
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text.trim());
        _messageController.clear();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
        _focusNode.requestFocus();
      });
    }
  }

  void _selectChat(Chat chat) {
    setState(() {
      _selectedChat = chat;
      _messages = [
        'Начало чата с ${chat.name}',
        'Привет!',
        'Как дела?',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildChatList(context),
          _buildMessageArea(context),
        ],
      ),
    );
  }

  Widget _buildChatList(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: colorScheme.outline)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colorScheme.outline)),
            ),
            child: Row(
              children: [
                Text(
                  'Чаты',
                  style: textTheme.titleLarge,
                ),
                const Spacer(),
                Icon(Icons.search, color: colorScheme.onSurface.withOpacity(0.6)),
                const SizedBox(width: 16),
                Icon(Icons.more_vert, color: colorScheme.onSurface.withOpacity(0.6)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return _ChatListItem(
                  chat: chat,
                  isSelected: _selectedChat?.id == chat.id,
                  onTap: () => _selectChat(chat),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colorScheme.outline)),
            ),
            child: Row(
              children: [
                PopupMenuButton<String>(
                  icon: CircleAvatar(
                    backgroundImage: AssetImage('assets/default-avatar.png'),
                  ),
                  onSelected: (value) {
                    if (value == 'profile') {
                      context.push('/profile');
                    } else if (value == 'logout') {
                      ref.read(authNotifierProvider.notifier).logout();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'profile',
                      child: Text('Профиль'),
                    ),
                    const PopupMenuItem(
                      value: 'logout',
                      child: Text('Выйти'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageArea(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (_selectedChat == null) {
      return Expanded(
        child: Center(
          child: Text(
            'Выберите чат для начала общения',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colorScheme.outline)),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(_selectedChat!.avatar),
                    ),
                    if (_selectedChat!.isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: colorScheme.surface, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedChat!.name,
                        style: textTheme.titleLarge,
                      ),
                      Text(
                        _selectedChat!.isOnline ? 'в сети' : 'был(а) недавно',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: colorScheme.onSurface.withOpacity(0.6)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _MessageBubble(message: _messages[index]);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: colorScheme.outline)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: colorScheme.onSurface.withOpacity(0.6)),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText: 'Сообщение...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    textInputAction: TextInputAction.send,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final Chat chat;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChatListItem({
    required this.chat,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      color: isSelected ? colorScheme.secondaryContainer : Colors.transparent,
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(chat.avatar),
            ),
            if (chat.isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.surface, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          chat.name,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          chat.lastMessage,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textTheme.bodySmall?.copyWith(
            color: isSelected
                ? colorScheme.primary.withOpacity(0.8)
                : colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              chat.time,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            if (chat.unreadCount > 0)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  chat.unreadCount.toString(),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Text(
            message,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
