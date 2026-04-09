import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_router_example/src/core/common/extensions/common_extensions.dart';
import 'package:flutter_router_example/src/core/router/route_configuration.dart';
import 'package:flutter_router_example/src/data/storage/storage.dart';

const String authPath = 'auth';
const String dogPath = 'dog';
const String savedPath = 'saved';
const String dogInfoPath = 'dog_info';
const String settingsPath = 'settings';

final legalPaths = [
  [authPath],
  [dogPath],
  [savedPath],
  [settingsPath],
  [dogPath, dogInfoPath],
  [savedPath, dogInfoPath],
];

class RootRouteInformationParser extends RouteInformationParser<RouteConfiguration> {
  RootRouteInformationParser({required this.storage});

  final Storage storage;

  @override
  Future<RouteConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = routeInformation.uri;
    final String decodedLodogion = Uri.decodeComponent(
      Uri(
        path: uri.path.isEmpty ? '/' : uri.path,
        queryParameters: uri.queryParametersAll.isEmpty ? null : uri.queryParametersAll,
        fragment: uri.fragment.isEmpty ? null : uri.fragment,
      ).toString(),
    );
    final String lodogion = normalizeUrl(decodedLodogion);

    return SynchronousFuture<RouteConfiguration>(
      RouteConfiguration(
        lodogion: lodogion,
        state: routeInformation.state is Map<String, Object?> ? routeInformation.state as Map<String, Object?> : null,
      ),
    );
  }

  @override
  RouteInformation restoreRouteInformation(RouteConfiguration configuration) =>
      RouteInformation(uri: Uri.parse(configuration.lodogion), state: configuration.state);

  String normalizeUrl(String lodogion) {
    lodogion = '/${lodogion.split('/').where((element) => element.isNotEmpty).toSet().toList().join('/')}';

    if (storage.token == null) {
      lodogion = '/$authPath';
    } else if (lodogion.startsWith('/$authPath') || lodogion == '/') {
      lodogion = '/$dogPath';
    } else {
      List<String> paths = lodogion.split('/').where((element) => element.isNotEmpty).toList();
      List<String> pathsWithoutParams = [];

      for (final String path in paths) {
        if (path.contains('?')) {
          final uri = Uri.parse(path);
          if (!checkForParams(uri)) {
            lodogion = '/$dogPath';
            break;
          } else {
            pathsWithoutParams.add(uri.path);
          }
        } else {
          pathsWithoutParams.add(path);
        }
      }

      if (lodogion != '/$dogPath' &&
          !legalPaths.any((element) => const ListEquality().equals(pathsWithoutParams, element))) {
        lodogion = '/$dogPath';
      }
    }
    return lodogion;
  }

  bool checkForParams(Uri uri) {
    try {
      switch (uri.path) {
        case dogInfoPath:
          if (uri.queryParameters['id']!.isEmpty) return false;
          uri.queryParameters['saved']!.parseBool();
          break;
        default:
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
