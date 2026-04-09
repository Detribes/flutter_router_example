import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_event.freezed.dart';

@freezed
abstract class SavedEvent with _$SavedEvent {
  const factory SavedEvent.load() = Load;
}
