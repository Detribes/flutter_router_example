import 'package:flutter_router_example/src/core/router/root_route_information_parser.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';

class DogInfoConfiguration extends RouteConfiguration {
  DogInfoConfiguration({required String id, required bool saved})
      : super(
          routePath: '/$dogInfoPath?id=$id&saved=$saved',
        );
}
