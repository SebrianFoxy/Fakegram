import 'package:flutter/material.dart';
import 'package:platform_plus/platform_plus.dart';

class PlatformUtils {
  static bool get isMobile => PlatformPlus.platform.isAndroidNative ||
      PlatformPlus.platform.isIOSNative;
  static bool get isDesktop => PlatformPlus.platform.isWindowsNative ||
      PlatformPlus.platform.isMacOSNative ||
      PlatformPlus.platform.isLinuxNative;
  static bool get isWeb => PlatformPlus.platform.isAndroidWeb ||
      PlatformPlus.platform.isIOSWeb ||
      PlatformPlus.platform.isWindowsWeb ||
      PlatformPlus.platform.isMacOSWeb ||
      PlatformPlus.platform.isLinuxWeb;
}

extension PlatformContext on BuildContext {
  bool get isMobile => PlatformUtils.isMobile;
  bool get isDesktop => PlatformUtils.isDesktop;
  bool get isWeb => PlatformUtils.isWeb;
}
