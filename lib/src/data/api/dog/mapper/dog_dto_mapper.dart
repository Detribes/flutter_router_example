import 'package:collection/collection.dart';
import 'package:flutter_router_example/src/data/api/dog/dto/dog_dto.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';

extension DogDTOMapper on DogDTO {
  Dog toDog() => Dog(id: id, breed: breeds.firstOrNull?.name ?? 'No breed', picture: url);
}
