import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/base_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/custom_page.dart';
import 'package:flutter_router_example/src/core/router/root_route_information_parser.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';
import 'package:flutter_router_example/src/presentation/auth/auth_screen.dart';
import 'package:flutter_router_example/src/presentation/main/main_screen.dart';

class RootRouterDelegate extends BaseRouterDelegate {
  RootRouterDelegate();

  void subscribeToNestedRouter(RouterDelegate<dynamic> nestedRouterDelegate) {
    nestedRouterDelegate.addListener(() {
      if (currentRouteConfiguration != nestedRouterDelegate.currentConfiguration) {
        currentRouteConfiguration = nestedRouterDelegate.currentConfiguration as RouteConfiguration?;
        notifyListeners();
      }
    });
  }

  @override
  Widget build(BuildContext context) => currentConfiguration != null ? super.build(context) : Container();

  @override
  List<Page<dynamic>> buildPages() {
    if (currentRouteConfiguration!.lodogion.startsWith('/$dogPath') ||
        currentRouteConfiguration!.lodogion.startsWith('/$savedPath') ||
        currentRouteConfiguration!.lodogion.startsWith('/$settingsPath')) {
      return [
        CustomPage(
          key: const ValueKey('main'),
          allowPop: canPop(),
          child: const MainScreen(),
        )
      ];
    } else {
      return super.buildPages();
    }
  }

  @override
  Widget getScreen(String lodogion, Map<String, Object?>? state) {
    late Widget screen;
    final uri = Uri.parse(lodogion);
    switch (uri.path) {
      case authPath:
        screen = const AuthScreen();
        break;
      default:
        screen = Container();
    }
    return screen;
  }

  int get currentTabIndex {
    if (currentRouteConfiguration!.lodogion.startsWith('/$dogPath')) {
      return 0;
    } else if (currentRouteConfiguration!.lodogion.startsWith('/$savedPath')) {
      return 1;
    } else if (currentRouteConfiguration!.lodogion.startsWith('/$settingsPath')) {
      return 2;
    } else {
      return 0;
    }
  }
}
