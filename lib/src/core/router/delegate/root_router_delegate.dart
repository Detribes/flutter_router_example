import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/base_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/custom_page.dart';
import 'package:flutter_router_example/src/core/router/root_route_information_parser.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';
import 'package:flutter_router_example/src/presentation/auth/auth_screen.dart';
import 'package:flutter_router_example/src/presentation/main/main_screen.dart';

class RootRouterDelegate extends BaseRouterDelegate {
  RootRouterDelegate();

  int get currentTabIndex {
    if (currentRouteConfiguration!.routePath.startsWith('/$dogPath')) {
      return 0;
    } else if (currentRouteConfiguration!.routePath.startsWith('/$savedPath')) {
      return 1;
    } else if (currentRouteConfiguration!.routePath.startsWith('/$settingsPath')) {
      return 2;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) => currentConfiguration != null ? super.build(context) : const SizedBox.shrink();

  @override
  List<Page<dynamic>> buildPages() {
    if (currentRouteConfiguration!.routePath.startsWith('/$dogPath') ||
        currentRouteConfiguration!.routePath.startsWith('/$savedPath') ||
        currentRouteConfiguration!.routePath.startsWith('/$settingsPath')) {
      return [CustomPage(key: const ValueKey('main'), allowPop: canPop(), child: const MainScreen())];
    } else {
      return super.buildPages();
    }
  }

  @override
  Widget getScreen(String segment, Map<String, Object?>? state) {
    late Widget screen;
    final uri = Uri.parse(segment);
    switch (uri.path) {
      case authPath:
        screen = const AuthScreen();
        break;
      default:
        screen = const SizedBox.shrink();
    }
    return screen;
  }

  void subscribeToNestedRouter(RouterDelegate<dynamic> nestedRouterDelegate) {
    nestedRouterDelegate.addListener(() {
      if (currentRouteConfiguration != nestedRouterDelegate.currentConfiguration) {
        currentRouteConfiguration = nestedRouterDelegate.currentConfiguration as RouteConfiguration?;
        notifyListeners();
      }
    });
  }
}
