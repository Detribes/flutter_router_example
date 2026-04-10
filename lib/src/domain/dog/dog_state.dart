import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dog_state.freezed.dart';

@freezed
abstract class DogState with _$DogState {
  const factory DogState({
    @Default([]) List<Dog> dogs,
    @Default(DogStatus.initialLoading) DogStatus status,
    @Default(0) int page,
    @Default(false) bool endOfList,
  }) = _DogState;
}

enum DogStatus { initialLoading, initialError, loading, data }
