import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_router_example/src/contracts/dog_repository.dart';
import 'package:flutter_router_example/src/domain/dog/dog_event.dart';
import 'package:flutter_router_example/src/domain/dog/dog_state.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  DogBloc({required this.dogRepository}) : super(const DogState()) {
    on<Fetch>(_fetch, transformer: droppable());
  }

  final DogRepository dogRepository;

  Future<void> _fetch(Fetch event, Emitter<DogState> emit) async {
    if (state.endOfList) return;
    emit(state.copyWith(status: state.status == DogStatus.data ? DogStatus.loading : DogStatus.initialLoading));
    try {
      final dogs = await dogRepository.fetchDogs(page: state.page, results: 20);
      emit(
        state.copyWith(
          status: DogStatus.data,
          dogs: state.dogs + dogs,
          page: state.page + 1,
          endOfList: dogs.length < 20,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: state.status == DogStatus.initialLoading ? DogStatus.initialError : DogStatus.data));
      rethrow;
    }
  }
}
