import 'dart:async';

class RouteConfiguration<T extends Object?> {
  RouteConfiguration({
    required this.lodogion,
    this.state,
    this.popCompleter,
  });

  late String lodogion;

  Map<String, Object?>? state;

  final Completer<T?>? popCompleter;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RouteConfiguration && other.lodogion == lodogion && other.state == state;
  }

  @override
  @override
  int get hashCode => Object.hash(lodogion, state);
}
