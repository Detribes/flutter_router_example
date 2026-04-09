import 'package:bloc/bloc.dart';
import 'package:flutter_router_example/src/contracts/auth_repository.dart';
import 'package:flutter_router_example/src/domain/auth/auth_event.dart';
import 'package:flutter_router_example/src/domain/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authRepository,
  }) : super(const AuthState()) {
    on<Login>(_login);
  }

  final AuthRepository authRepository;

  Future<void> _login(
    Login event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.login();
    emit(state.copyWith(
      action: AuthAction.authorized,
    ));
  }
}
