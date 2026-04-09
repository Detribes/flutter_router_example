import 'package:flutter_router_example/src/data/api/dog/dog_api.dart';
import 'package:flutter_router_example/src/di/factory/dependency_factory.dart';

abstract class BackendFactory {
  DogApi get dogApi;
}

class BackendFactoryImpl implements BackendFactory {
  BackendFactoryImpl({required DependencyFactory dependenciesFactory}) : _dependenciesFactory = dependenciesFactory;

  final DependencyFactory _dependenciesFactory;

  @override
  DogApi get dogApi => DogApi(_dependenciesFactory.dio);
}
