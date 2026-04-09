import 'package:freezed_annotation/freezed_annotation.dart';

part 'dog_info_event.freezed.dart';

@freezed
abstract class DogInfoEvent with _$DogInfoEvent {
  const factory DogInfoEvent.load() = Load;

  const factory DogInfoEvent.save() = Save;
}
