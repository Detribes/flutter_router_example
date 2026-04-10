import 'package:flutter_router_example/src/domain/entities/dog.dart';

abstract class DogRepository {
  Future<List<Dog>> fetchDogs({required int page, required int results});

  Future<Dog> fetchDog({required String id});

  Future<void> saveDog({required Dog dog});

  Future<List<Dog>> getSavedDogs();

  Future<Dog> getSavedDog({required String id});
}
