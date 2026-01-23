part of 'widgets.dart';

class MessagesList extends ConsumerWidget {
  final String chatId;
  final ScrollController scrollController;
  final _scrollThreshold = 200.0;

  const MessagesList({
    super.key,
    required this.chatId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageState = ref.watch(messageNotifierProvider);

    return NotificationListener<ScrollNotification>(
      // onNotification: (ScrollNotification scrollInfo) {
      //   if (scrollInfo.metrics.pixels >=
      //       scrollInfo.metrics.maxScrollExtent - _scrollThreshold) {
      //     _loadMoreMessages(ref);
      //   }
      //   return false;
      // },
      child: switch (messageState) {
        MessageStateInitial() => _buildEmptyState(),
        MessageStateLoading() => _buildLoadingState(),
        MessageStateSuccessLoading(messages: final messages) => Column(
            children: [
              Expanded(
                child: _buildMessagesList(messages, ref),
              ),
            ],
        ),
        _ => const Center(
          child: CircularProgressIndicator(),
        ),
      }
    );
  }

  Widget _buildMessagesList(List<MessageEntity> messages, WidgetRef ref) {
    if (messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'Нет сообщений',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Text(
              'Начните диалог первым!',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      reverse: true,
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final showDate = _shouldShowDate(index, messages);

        return Column(
          children: [
            if (showDate) _buildDateSeparator(message.createdAt),
            MessageBubble(
              message: message,
            ),
          ],
        );
      },
    );
  }

  bool _shouldShowDate(int index, List<MessageEntity> messages) {
    if (index == messages.length - 1) return true;

    final current = messages[index];
    final next = messages[index + 1];
    return !_isSameDay(current.createdAt, next.createdAt);
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildDateSeparator(DateTime date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _formatDate(date),
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Сегодня';
    } else if (messageDate == yesterday) {
      return 'Вчера';
    } else {
      return DateFormat('dd MMMM yyyy').format(date);
    }
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Загрузка сообщений...',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Выберите чат',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}