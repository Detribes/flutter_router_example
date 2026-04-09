import 'package:flutter/widgets.dart';
import 'package:flutter_router_example/src/di/factory/bloc_factory.dart';
import 'package:flutter_router_example/src/di/factory/dependency_factory.dart';

class DependencyScope extends StatefulWidget {
  const DependencyScope({super.key, required this.dependenciesFactory, required this.blocFactory, required this.child});

  final DependencyFactory dependenciesFactory;
  final BlocFactory blocFactory;
  final Widget child;

  static DependencyFactory getDependenciesFactory(BuildContext context) => _scopeOf(context).dependenciesFactory;

  static BlocFactory getBlocFactory(BuildContext context) => _scopeOf(context).blocFactory;

  static DependencyScope _scopeOf(BuildContext context) =>
      (context.getElementForInheritedWidgetOfExactType<_InheritedDependencyScope>()!.widget
              as _InheritedDependencyScope)
          .state
          .widget;

  @override
  State<DependencyScope> createState() => _DependencyScopeState();
}

class _DependencyScopeState extends State<DependencyScope> {

  @override
  void dispose() {
    widget.dependenciesFactory.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _InheritedDependencyScope(state: this, child: widget.child);

}

class _InheritedDependencyScope extends InheritedWidget {
  const _InheritedDependencyScope({required super.child, required this.state});

  final _DependencyScopeState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
