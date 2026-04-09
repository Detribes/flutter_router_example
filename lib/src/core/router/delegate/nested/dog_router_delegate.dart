import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/router/nested_router_delegate.dart';
import 'package:flutter_router_example/src/core/router/root_route_information_parser.dart';
import 'package:flutter_router_example/src/presentation/dog/dog_screen.dart';
import 'package:flutter_router_example/src/presentation/dog_info/dog_info_screen.dart';

class DogRouterDelegate extends NestedRouterDelegate {
  @override
  String get prefix => '/$dogPath';

  @override
  Widget getScreen(String segment, Map<String, Object?>? state) {
    late Widget screen;
    final uri = Uri.parse(segment);
    switch (uri.path) {
      case dogPath:
        screen = const DogScreen();
        break;
      case dogInfoPath:
        Map<String, String> arguments = uri.queryParameters;
        screen = DogInfoScreen(
          id: arguments['id']!,
          saved: arguments['saved']!.toLowerCase() == 'true',
        );
        break;
      default:
        screen = Container();
    }
    return screen;
  }
}
