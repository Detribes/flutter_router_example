import 'package:flutter_router_example/src/di/factory/repository_factory.dart';
import 'package:flutter_router_example/src/domain/auth/auth_bloc.dart';
import 'package:flutter_router_example/src/domain/dog/dog_bloc.dart';
import 'package:flutter_router_example/src/domain/dog_info/dog_info_bloc.dart';
import 'package:flutter_router_example/src/domain/saved_dog/saved_bloc.dart';
import 'package:flutter_router_example/src/domain/settings/settings_bloc.dart';

abstract class BlocFactory {
  AuthBloc get authBloc;

  DogBloc get dogBloc;

  SavedBloc get savedBloc;

  SettingsBloc get settingsBloc;

  DogInfoBloc getDogInfoBloc({
    required String id,
    required bool saved,
  });
}

class BlocFactoryImpl implements BlocFactory {
  BlocFactoryImpl({
    required RepositoryFactory repositoryFactory,
  }) : _repositoryFactory = repositoryFactory;

  final RepositoryFactory _repositoryFactory;

  @override
  AuthBloc get authBloc => AuthBloc(authRepository: _repositoryFactory.authRepository);

  @override
  DogBloc get dogBloc => DogBloc(dogRepository: _repositoryFactory.dogRepository);

  @override
  SavedBloc get savedBloc => SavedBloc(
        dogRepository: _repositoryFactory.dogRepository,
        refreshSavedRepository: _repositoryFactory.refreshSavedRepository,
      );

  @override
  SettingsBloc get settingsBloc => SettingsBloc(authRepository: _repositoryFactory.authRepository);

  @override
  DogInfoBloc getDogInfoBloc({
    required String id,
    required bool saved,
  }) =>
      DogInfoBloc(
        id: id,
        saved: saved,
        dogRepository: _repositoryFactory.dogRepository,
        refreshSavedRepository: _repositoryFactory.refreshSavedRepository,
      );
}
