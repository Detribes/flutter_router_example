import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_router_example/src/data/database/dao/dog_dao.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:flutter_router_example/src/domain/errors/dog_not_found_exception.dart';
import 'package:flutter_router_example/src/data/storage/storage.dart';

class DogWebStorageService implements DogDao {
  DogWebStorageService({required this.storage});

  final Storage storage;

  @override
  Future<void> saveDog({required Dog dog}) async {
    final List<Dog> dogs = await getDogs();
    dogs.add(dog);
    await storage.saveDogs(json: jsonEncode(dogs));
  }

  @override
  Future<List<Dog>> getDogs() async {
    final json = storage.dogs;
    return json != null
        ? (jsonDecode(json) as List<dynamic>).map((e) => Dog.fromJson(e as Map<String, dynamic>)).toList()
        : [];
  }

  @override
  Future<Dog> getDog({required String id}) async {
    final Dog? dog = (await getDogs()).firstWhereOrNull((dog) => dog.id == id);
    return dog ?? (throw DogNotFoundException());
  }
}
