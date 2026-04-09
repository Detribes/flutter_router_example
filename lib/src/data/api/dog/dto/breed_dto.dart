import 'package:json_annotation/json_annotation.dart';

part 'breed_dto.g.dart';

@JsonSerializable()
class BreedDTO {
  BreedDTO({required this.name});

  String name;

  factory BreedDTO.fromJson(Map<String, dynamic> json) => _$BreedDTOFromJson(json);

  Map<String, dynamic> toJson() => _$BreedDTOToJson(this);
}
