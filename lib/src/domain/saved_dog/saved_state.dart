import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_state.freezed.dart';

@freezed
abstract class SavedState with _$SavedState {
  const factory SavedState({@Default([]) List<Dog> dogs}) = _SavedState;
}
