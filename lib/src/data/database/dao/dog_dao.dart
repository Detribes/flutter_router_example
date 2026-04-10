import 'package:flutter_router_example/src/domain/entities/dog.dart';

abstract class DogDao {
  Future<void> saveDog({required Dog dog});

  Future<List<Dog>> getDogs();

  Future<Dog> getDog({required String id});
}
