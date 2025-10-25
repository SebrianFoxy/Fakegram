import 'package:fakegram/data/models/direct_message/direct_message_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/direct_chat/direct_chat_model.dart';
import '../../presenter/auth/notifier/auth_notifier.dart';
import '../../presenter/messages/notifier/messages_notifier.dart';
import '../routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



// Inputs
part 'inputs/auth_input.dart';


//messages
part 'messages/messages_bubble.dart';
part 'messages/messages_input.dart';
part 'messages/chat_list_item.dart';
part 'messages/chat_header.dart';
part 'messages/messages_list.dart';
part 'messages/user_panel.dart';
part 'messages/chat_list.dart';
part 'messages/message_area.dart';
part 'messages/chat_list_header.dart';