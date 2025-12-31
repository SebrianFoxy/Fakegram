import 'package:fakegram/features/chat/domain/entities/direct_chat_entity.dart';
import 'package:fakegram/features/chat/domain/entities/direct_message_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/notifier/auth_notifier.dart';
import '../../../websocket/presentation/notifier/websocket_notifier.dart';
import '../../data/models/direct_message_model.dart';
import '../notifier/chat_notifier.dart';


part 'chat_header.dart';
part 'chat_list.dart';
part 'chat_list_header.dart';
part 'chat_list_item.dart';
part 'message_area.dart';
part 'messages_bubble.dart';
part 'messages_input.dart';
part 'messages_list.dart';
part 'user_panel.dart';

part '../page/chat_page.dart';