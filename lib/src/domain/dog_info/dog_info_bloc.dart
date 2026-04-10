import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_router_example/src/contracts/dog_repository.dart';
import 'package:flutter_router_example/src/contracts/refresh_saved_repository.dart';
import 'package:flutter_router_example/src/domain/dog_info/dog_info_event.dart';
import 'package:flutter_router_example/src/domain/dog_info/dog_info_state.dart';
import 'package:flutter_router_example/src/domain/errors/dog_not_found_exception.dart';

class DogInfoBloc extends Bloc<DogInfoEvent, DogInfoState> {
  DogInfoBloc({
    required this.dogRepository,
    required this.refreshSavedRepository,
    required String id,
    required bool saved,
  }) : super(DogInfoState(id: id, saved: saved)) {
    on<Load>(_load);
    on<Save>(_save, transformer: droppable());
  }

  final DogRepository dogRepository;
  final RefreshSavedRepository refreshSavedRepository;

  Future<void> _load(Load event, Emitter<DogInfoState> emit) async {
    emit(state.copyWith(status: DogInfoStatus.loading));
    try {
      final dog = await (state.saved ? dogRepository.getSavedDog(id: state.id) : dogRepository.fetchDog(id: state.id));
      emit(state.copyWith(status: DogInfoStatus.data, dog: dog));
    } on DogNotFoundException {
      emit(state.copyWith(status: DogInfoStatus.dogNotFound));
    } catch (_) {
      emit(state.copyWith(status: DogInfoStatus.fetchError));
      rethrow;
    }
  }

  Future<void> _save(Save event, Emitter<DogInfoState> emit) async {
    if (state.status != DogInfoStatus.data) return;
    try {
      await dogRepository.saveDog(dog: state.dog);
      refreshSavedRepository.refreshSaved();
      emit(state.copyWith(action: DogInfoAction.saved));
    } catch (_) {
      rethrow;
    } finally {
      emit(state.copyWith(action: DogInfoAction.none));
    }
  }
}
