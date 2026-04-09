import 'package:flutter_router_example/src/di/factory/bloc_factory.dart';
import 'package:flutter_router_example/src/di/factory/dependency_factory.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'initialization_result.freezed.dart';

@freezed
abstract class InitializationResult with _$InitializationResult {
  const InitializationResult._();

  const factory InitializationResult({
    required DependencyFactory dependenciesFactory,
    required BlocFactory blocFactory,
  }) = _InitializationResult;
}
