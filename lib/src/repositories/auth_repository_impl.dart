import 'package:flutter_router_example/src/contracts/auth_repository.dart';
import 'package:flutter_router_example/src/data/storage/storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.storage});

  Storage storage;

  @override
  Future<void> login() => storage.saveToken(token: 'token');

  @override
  Future<void> logout() => storage.clearToken();
}
