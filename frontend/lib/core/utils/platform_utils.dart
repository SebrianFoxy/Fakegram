import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class PlatformUtils {
  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
  static bool get isDesktop => !isMobile && !kIsWeb;
  static bool get isWeb => kIsWeb;
}

extension PlatformContext on BuildContext {
  bool get isMobile => PlatformUtils.isMobile;
  bool get isDesktop => PlatformUtils.isDesktop;
}