import 'package:dio/dio.dart';
import 'package:flutter_router_example/src/core/common/constants.dart';
import 'package:flutter_router_example/src/data/api/dog/dto/dog_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'dog_api.g.dart';

@RestApi()
abstract class DogApi {
  factory DogApi(Dio dio, {String baseUrl}) = _DogApi;

  @GET('/images/search')
  Future<List<DogDTO>> fetchDogs({
    @Query('page') required int page,
    @Query('limit') required int results,
    @Query('api_key') String apiKey = Constants.apiKey,
    @Query('has_breeds') int hasBreeds = 1,
  });

  @GET('/images/{id}')
  Future<DogDTO> fetchDog({@Path('id') required String id});
}
