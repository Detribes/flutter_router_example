import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SettingsAction.none) SettingsAction action,
  }) = _SettingsState;
}

enum SettingsAction {
  none,
  logout,
}
