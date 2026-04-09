import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/base_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/nested_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/scope/root_router_scope.dart';
import 'package:flutter_router_example/src/core/router/scope/router_scope.dart';
import 'package:flutter_router_example/src/di/dependency_scope.dart';

class TabRouter extends StatefulWidget {
  const TabRouter({super.key, required this.delegateMap, required this.builder});

  final Map<String, BaseRouterDelegate> delegateMap;
  final Widget Function(BuildContext context, Widget child) builder;

  static TabRouterState of(BuildContext context) =>
      (context.getElementForInheritedWidgetOfExactType<_InheritedTabRouterScope>()!.widget as _InheritedTabRouterScope)
          .state;

  @override
  State<TabRouter> createState() => TabRouterState();
}

class TabRouterState extends State<TabRouter> {
  late List<ChildBackButtonDispatcher> childBackButtonDispatchers;
  late List<RouterScope> routers;
  late final List<BaseRouterDelegate> delegates;
  int currentTab = 0;

  @override
  void initState() {
    super.initState();
    delegates = widget.delegateMap.values.toList();
    final rootBackButtonDispatcher = DependencyScope.getDependenciesFactory(context).rootBackButtonDispatcher;
    childBackButtonDispatchers = List.generate(
      delegates.length,
      (_) => ChildBackButtonDispatcher(rootBackButtonDispatcher),
    );
    final rootRouterDelegate = RootRouterScope.of(context).delegate;

    for (final nestedRouterDelegate in delegates) {
      rootRouterDelegate.subscribeToNestedRouter(nestedRouterDelegate);

      (nestedRouterDelegate as NestedRouterDelegate).subscribeToRootRouterDelegate(rootRouterDelegate);

      if (rootRouterDelegate.currentConfiguration?.lodogion.startsWith(nestedRouterDelegate.prefix) ?? false) {
        nestedRouterDelegate.setInitialRoutePath(rootRouterDelegate.currentConfiguration!);
      }
    }

    rootRouterDelegate.addListener(() {
      int newIndex = rootRouterDelegate.currentTabIndex;
      if (currentTab != newIndex) {
        changeTab(newIndex, updateDelegate: false);
      }
    });

    routers = delegates
        .mapIndexed(
          (index, routerDelegate) => RouterScope(
            routerDelegate: routerDelegate,
            child: Router(routerDelegate: routerDelegate, backButtonDispatcher: childBackButtonDispatchers[index]),
          ),
        )
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _update();
    });
  }

  void changeTab(int index, {bool updateDelegate = true}) {
    currentTab = index;
    if (updateDelegate) {
      _update();
    }
    setState(() {});
  }

  void _update() {
    delegates[currentTab].update();
    childBackButtonDispatchers[currentTab].takePriority();
  }

  BaseRouterDelegate delegateByPath(String path) => widget.delegateMap[path]!;

  @override
  Widget build(BuildContext context) => _InheritedTabRouterScope(
    state: this,
    child: Builder(builder: (context) => widget.builder(context, _buildStack())),
  );

  Widget _buildStack() => IndexedStack(index: currentTab, children: routers);
}

class _InheritedTabRouterScope extends InheritedWidget {
  const _InheritedTabRouterScope({required Widget child, required this.state}) : super(child: child);

  final TabRouterState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
