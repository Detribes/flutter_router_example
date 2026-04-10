import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/custom_page.dart';
import 'package:flutter_router_example/src/core/router/page_builder.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';

abstract class BaseRouterDelegate extends RouterDelegate<RouteConfiguration> with ChangeNotifier {
  BaseRouterDelegate();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  RouteConfiguration? currentRouteConfiguration;

  @override
  RouteConfiguration? get currentConfiguration => currentRouteConfiguration;

  @override
  Widget build(BuildContext context) => PageBuilder(
    configuration: currentConfiguration!,
    pageBuilder: buildPages,
    builder: (context, pages) => Navigator(
      key: _navigatorKey,
      pages: pages,
      onDidRemovePage: (page) {
        _trimConfiguration();
      },
    ),
  );

  @override
  Future<void> setInitialRoutePath(RouteConfiguration configuration) {
    currentRouteConfiguration = configuration;
    return super.setInitialRoutePath(configuration);
  }

  @override
  Future<bool> popRoute() =>
      _navigatorKey.currentState != null ? _navigatorKey.currentState!.maybePop() : SynchronousFuture<bool>(false);

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) {
    if (currentRouteConfiguration == configuration) {
      return SynchronousFuture<void>(null);
    }
    currentRouteConfiguration = configuration;
    notifyListeners();
    return SynchronousFuture<void>(null);
  }

  @optionalTypeArgs
  Future<T?> push<T extends Object?>(RouteConfiguration configuration) {
    Map<String, Object?>? newState;

    if (currentRouteConfiguration!.state != null || configuration.state != null) {
      newState = <String, Object?>{};
      if (currentRouteConfiguration!.state != null) {
        newState.addAll(currentRouteConfiguration!.state!);
      }
      if (configuration.state != null) {
        newState.addAll(configuration.state!);
      }
    }

    final popCompleter = Completer<T?>();
    currentRouteConfiguration = RouteConfiguration(
      routePath: '${currentRouteConfiguration!.routePath}${configuration.routePath}',
      state: newState,
      popCompleter: popCompleter,
    );

    notifyListeners();
    return popCompleter.future;
  }

  Future<void> navigate(RouteConfiguration configuration) => setNewRoutePath(configuration);

  void update() => notifyListeners();

  List<Page<dynamic>> buildPages() {
    List<String> paths = currentRouteConfiguration!.routePath.split('/').where((e) => e.isNotEmpty).toList();

    final pages = paths
        .mapIndexed(
          (index, segment) => CustomPage(
            key: ValueKey(segment),
            allowPop: index == paths.length - 1 ? canPop() : true,
            child: getScreen(segment, currentRouteConfiguration!.state),
            popCompleter: index == paths.length - 1 && currentRouteConfiguration?.popCompleter != null
                ? currentRouteConfiguration!.popCompleter
                : null,
          ),
        )
        .toList();
    return pages;
  }

  Widget getScreen(String segment, Map<String, Object?>? state);

  Future<bool> pop<T extends Object?>([T? result]) {
    return _navigatorKey.currentState != null
        ? _navigatorKey.currentState!.maybePop(result)
        : SynchronousFuture<bool>(false);
  }

  bool canPop() => currentRouteConfiguration!.routePath.split('/').where((e) => e.isNotEmpty).toList().length > 1;

  void _trimConfiguration() {
    final paths = currentRouteConfiguration!.routePath.split('/').where((e) => e.isNotEmpty).toList();
    final newConfiguration = RouteConfiguration(
      routePath: '/${paths.take(paths.length - 1).join('/')}',
      state: currentRouteConfiguration!.state,
    );
    setNewRoutePath(newConfiguration);
  }
}
