import 'package:flutter_router_example/src/contracts/auth_repository.dart';
import 'package:flutter_router_example/src/contracts/dog_repository.dart';
import 'package:flutter_router_example/src/contracts/refresh_saved_repository.dart';
import 'package:flutter_router_example/src/di/factory/backend_factory.dart';
import 'package:flutter_router_example/src/di/factory/database_factory.dart';
import 'package:flutter_router_example/src/di/factory/dependency_factory.dart';
import 'package:flutter_router_example/src/repositories/auth_repository_impl.dart';
import 'package:flutter_router_example/src/repositories/dog_repository_impl.dart';
import 'package:flutter_router_example/src/repositories/refresh_saved_repository_impl.dart';

abstract class RepositoryFactory {
  AuthRepository get authRepository;

  DogRepository get dogRepository;

  RefreshSavedRepository get refreshSavedRepository;
}

class RepositoryFactoryImpl implements RepositoryFactory {
  RepositoryFactoryImpl({
    required DependencyFactory dependencyFactory,
    required DatabaseFactory databaseFactory,
    required BackendFactory backendFactory,
  })  : _dependencyFactory = dependencyFactory,
        _databaseFactory = databaseFactory,
        _backendFactory = backendFactory;

  final DependencyFactory _dependencyFactory;

  final DatabaseFactory _databaseFactory;

  final BackendFactory _backendFactory;

  AuthRepository? _authRepository;

  DogRepository? _dogRepository;

  final RefreshSavedRepository _refreshSavedRepository = RefreshSavedRepositoryImpl();

  @override
  AuthRepository get authRepository => _authRepository ??= AuthRepositoryImpl(
        storage: _dependencyFactory.storage,
      );

  @override
  DogRepository get dogRepository => _dogRepository ??= DogRepositoryImpl(
        dogApi: _backendFactory.dogApi,
        dogDao: _databaseFactory.dogDao,
      );

  @override
  RefreshSavedRepository get refreshSavedRepository => _refreshSavedRepository;
}
