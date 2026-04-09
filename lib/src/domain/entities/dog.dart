import 'package:freezed_annotation/freezed_annotation.dart';

part 'dog.freezed.dart';
part 'dog.g.dart';

@freezed
abstract class Dog with _$Dog {
  const Dog._();

  const factory Dog({
    @JsonKey(name: 'id') @Default('') String id,
    @JsonKey(name: 'breed') @Default('') String breed,
    @JsonKey(name: 'picture') @Default('') String picture,
  }) = _Dog;

  factory Dog.fromJson(Map<String, dynamic> json) => _$DogFromJson(json);
}
