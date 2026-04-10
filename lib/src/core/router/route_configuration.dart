import 'dart:async';

class RouteConfiguration<T extends Object?> {
  RouteConfiguration({required this.routePath, this.state, this.popCompleter});

  final String routePath;

  final Completer<T?>? popCompleter;

  Map<String, Object?>? state;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RouteConfiguration && other.routePath == routePath && other.state == state;
  }

  @override
  int get hashCode => Object.hash(routePath, state);
}
