import 'package:flutter_router_example/src/core/router/base_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/delegate/root_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';

abstract class NestedRouterDelegate extends BaseRouterDelegate {
  NestedRouterDelegate() {
    currentRouteConfiguration = RouteConfiguration(routePath: prefix);
  }

  String get prefix;

  void subscribeToRootRouterDelegate(RootRouterDelegate rootRouterDelegate) {
    rootRouterDelegate.addListener(() {
      if ((rootRouterDelegate.currentConfiguration?.routePath.startsWith(prefix) ?? false) &&
          currentRouteConfiguration != rootRouterDelegate.currentConfiguration) {
        currentRouteConfiguration = rootRouterDelegate.currentConfiguration;
        notifyListeners();
      }
    });
  }
}
