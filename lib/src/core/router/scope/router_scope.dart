import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/base_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';

class RouterScope extends InheritedWidget {
  const RouterScope({super.key, required BaseRouterDelegate routerDelegate, required super.child})
    : _routerDelegate = routerDelegate;

  final BaseRouterDelegate _routerDelegate;

  static RouterScope of(BuildContext context) =>
      context.getElementForInheritedWidgetOfExactType<RouterScope>()!.widget as RouterScope;

  BaseRouterDelegate get delegate => _routerDelegate;

  @override
  bool updateShouldNotify(RouterScope oldWidget) => false;

  Future<bool> pop<T extends Object?>([T? result]) => _routerDelegate.pop(result);

  Future<T?> push<T extends Object?>(RouteConfiguration configuration) => _routerDelegate.push(configuration);

  void navigate(RouteConfiguration configuration) => _routerDelegate.navigate(configuration);
}
