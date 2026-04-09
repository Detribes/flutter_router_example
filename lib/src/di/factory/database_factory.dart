import 'package:flutter_router_example/src/data/database/dao/dog_dao_impl.dart';
import 'package:flutter_router_example/src/data/database/dao/dog_dao_web_impl.dart';
import 'package:flutter_router_example/src/di/factory/dependency_factory.dart';

abstract class DatabaseFactory {
  DogDao get dogDao;
}

class DatabaseFactoryImpl implements DatabaseFactory {
  DatabaseFactoryImpl({required DependencyFactory dependenciesFactory}) : _dependenciesFactory = dependenciesFactory;

  final DependencyFactory _dependenciesFactory;

  DogDao? _dogDao;

  @override
  DogDao get dogDao => _dogDao ??= DogDaoImpl(database: _dependenciesFactory.database!);
}

class DatabaseWebFactoryImpl implements DatabaseFactory {
  DatabaseWebFactoryImpl({required DependencyFactory dependenciesFactory}) : _dependenciesFactory = dependenciesFactory;

  final DependencyFactory _dependenciesFactory;

  DogDao? _dogDao;

  @override
  DogDao get dogDao => _dogDao ??= DogDaoWebImpl(storage: _dependenciesFactory.storage);
}
