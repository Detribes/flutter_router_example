import 'package:flutter_router_example/src/data/database/dao/dog_dao.dart';
import 'package:flutter_router_example/src/data/database/services/dog_database_service.dart';
import 'package:flutter_router_example/src/data/database/services/dog_web_storage_service.dart';
import 'package:flutter_router_example/src/di/factory/dependency_factory.dart';

abstract class DatabaseFactory {
  DogDao get dogDao;
}

class DatabaseFactoryImpl implements DatabaseFactory {
  DatabaseFactoryImpl({required DependencyFactory dependenciesFactory}) : _dependenciesFactory = dependenciesFactory;

  final DependencyFactory _dependenciesFactory;

  DogDao? _dogDao;

  @override
  DogDao get dogDao => _dogDao ??= DogDatabaseService(database: _dependenciesFactory.database!);
}

class DatabaseWebFactoryImpl implements DatabaseFactory {
  DatabaseWebFactoryImpl({required DependencyFactory dependenciesFactory}) : _dependenciesFactory = dependenciesFactory;

  final DependencyFactory _dependenciesFactory;

  DogDao? _dogDao;

  @override
  DogDao get dogDao => _dogDao ??= DogWebStorageService(storage: _dependenciesFactory.storage);
}
