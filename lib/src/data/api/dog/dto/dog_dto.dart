import 'package:flutter_router_example/src/data/api/dog/dto/breed_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dog_dto.g.dart';

@JsonSerializable()
class DogDTO {
  DogDTO({required this.id, required this.url, required this.breeds});

  String id;
  String url;
  List<BreedDTO> breeds;

  factory DogDTO.fromJson(Map<String, dynamic> json) => _$DogDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DogDTOToJson(this);
}
