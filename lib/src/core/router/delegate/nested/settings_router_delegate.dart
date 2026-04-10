import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/nested_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/root_route_information_parser.dart';
import 'package:flutter_router_example/src/presentation/settings/settings_screen.dart';

class SettingsRouterDelegate extends NestedRouterDelegate {
  @override
  String get prefix => '/$settingsPath';

  @override
  Widget getScreen(String segment, Map<String, Object?>? state) {
    late Widget screen;
    final uri = Uri.parse(segment);
    switch (uri.path) {
      case settingsPath:
        screen = const SettingsScreen();
        break;
      default:
        screen = const SizedBox.shrink();
    }
    return screen;
  }
}
