import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dog_info_state.freezed.dart';

@freezed
abstract class DogInfoState with _$DogInfoState {
  const factory DogInfoState({
    @Default('') String id,
    @Default(false) bool saved,
    @Default(Dog()) Dog dog,
    @Default(DogInfoStatus.loading) DogInfoStatus status,
    @Default(DogInfoAction.none) DogInfoAction action,
  }) = _DogInfoState;
}

enum DogInfoStatus { loading, fetchError, dogNotFound, data }

enum DogInfoAction { none, saved }
