import 'package:freezed_annotation/freezed_annotation.dart';

part 'dog_event.freezed.dart';

@freezed
abstract class DogEvent with _$DogEvent {
  const factory DogEvent.fetch() = Fetch;
}
