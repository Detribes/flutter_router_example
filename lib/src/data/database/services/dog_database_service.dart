import 'package:flutter_router_example/src/data/database/dao/dog_dao.dart';
import 'package:flutter_router_example/src/data/database/database_helper.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:flutter_router_example/src/domain/errors/dog_not_found_exception.dart';
import 'package:sqflite/sqflite.dart';

class DogDatabaseService implements DogDao {
  DogDatabaseService({required this.database});

  final Database database;

  @override
  Future<void> saveDog({required Dog dog}) async {
    await database.insert(dogTableName, dog.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Dog>> getDogs() async => (await database.query(dogTableName)).map((e) => Dog.fromJson(e)).toList();

  @override
  Future<Dog> getDog({required String id}) async {
    final result = await database.query(dogTableName, where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? Dog.fromJson(result.first) : throw DogNotFoundException();
  }
}
