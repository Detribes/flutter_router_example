import 'package:flutter_router_example/src/contracts/dog_repository.dart';
import 'package:flutter_router_example/src/data/api/dog/dog_api.dart';
import 'package:flutter_router_example/src/data/api/dog/mapper/dog_dto_mapper.dart';
import 'package:flutter_router_example/src/data/database/dao/dog_dao_impl.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';

class DogRepositoryImpl implements DogRepository {
  DogRepositoryImpl({
    required this.dogApi,
    required this.dogDao,
  });

  DogApi dogApi;

  DogDao dogDao;

  @override
  Future<List<Dog>> fetchDogs({
    required int page,
    required int results,
  }) async =>
      (await dogApi.fetchDogs(page: page, results: results)).map((e) => e.toDog()).toList();

  @override
  Future<Dog> fetchDog({required String id}) async => (await dogApi.fetchDog(id: id)).toDog();

  @override
  Future<void> saveDog({required Dog dog}) => dogDao.saveDog(dog: dog);

  @override
  Future<Dog> getSavedDog({required String id}) => dogDao.getDog(id: id);

  @override
  Future<List<Dog>> getSavedDogs() => dogDao.getDogs();
}
