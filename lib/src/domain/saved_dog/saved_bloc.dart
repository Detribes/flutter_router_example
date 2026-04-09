import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_router_example/src/contracts/dog_repository.dart';
import 'package:flutter_router_example/src/contracts/refresh_saved_repository.dart';
import 'package:flutter_router_example/src/domain/entities/dog.dart';
import 'package:flutter_router_example/src/domain/saved_dog/saved_event.dart';
import 'package:flutter_router_example/src/domain/saved_dog/saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  SavedBloc({
    required this.dogRepository,
    required this.refreshSavedRepository,
  }) : super(const SavedState()) {
    on<Load>(_load);

    initSubscriptions();
  }

  final DogRepository dogRepository;
  final RefreshSavedRepository refreshSavedRepository;
  StreamSubscription<void>? _refreshSavedStreamSubscription;

  void initSubscriptions() {
    _refreshSavedStreamSubscription =
        refreshSavedRepository.refreshSavedStream.listen((event) => add(const SavedEvent.load()));
  }

  Future<void> _load(
    Load event,
    Emitter<SavedState> emit,
  ) async {
    try {
      final List<Dog> dogs = await dogRepository.getSavedDogs();
      emit(state.copyWith(
        dogs: dogs,
      ));
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> close() {
    _refreshSavedStreamSubscription?.cancel();
    return super.close();
  }
}
