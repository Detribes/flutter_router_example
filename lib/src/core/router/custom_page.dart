import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomPage<T> extends Page<T> {
  const CustomPage({
    required this.child,
    this.popCompleter,
    this.allowPop = true,
    LocalKey? key,
  }) : super(key: key);

  final bool allowPop;
  final Completer<T?>? popCompleter;
  final Widget child;

  @override
  bool get canPop => allowPop;

  @override
  Route<T> createRoute(BuildContext context) {
    final PageRoute<T> route = kIsWeb
        ? PageRouteBuilder<T>(
            settings: this,
            pageBuilder: (_, _, _) => child,
          )
        : MaterialPageRoute<T>(
            settings: this,
            builder: (_) => child,
          );
    route.popped.then((result) => popCompleter?.complete(result));
    return route;
  }
}
