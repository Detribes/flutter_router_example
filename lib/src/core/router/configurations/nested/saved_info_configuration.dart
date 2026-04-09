import 'package:flutter_router_example/src/core/router/root_route_information_parser.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';

class SavedInfoConfiguration extends RouteConfiguration {
  SavedInfoConfiguration({required String id}) : super(lodogion: '/$savedPath/$dogInfoPath?id=$id&saved=true');
}
