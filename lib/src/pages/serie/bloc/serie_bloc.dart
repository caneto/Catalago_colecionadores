import 'package:bloc/bloc.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';

import 'serie_event.dart';
import 'serie_state.dart';

class SerieBloc extends Bloc<SerieEvent, SerieState> {
  final IsarService _isarService;

  SerieBloc(this._isarService) : super(SerieInitial()) {
    on<LoadSeries>(_onLoadSeries);
    on<AddSerie>(_onAddSerie);
    on<DeleteSerie>(_onDeleteSerie);
  }

  Future<void> _onLoadSeries(LoadSeries event, Emitter<SerieState> emit) async {
    emit(SerieLoading());
    try {
      final series = await _isarService.getAllSeries();
      emit(SerieLoaded(series));
    } catch (e) {
      emit(SerieError('Erro ao carregar series: $e'));
    }
  }

  Future<void> _onAddSerie(AddSerie event, Emitter<SerieState> emit) async {
    emit(SerieLoading());
    try {
      await _isarService.saveSerie(event.serie);
      emit(const SerieOperationSuccess('Serie salva com sucesso!'));
      add(LoadSeries());
    } catch (e) {
      emit(SerieError('Erro ao salvar serie: $e'));
    }
  }

  Future<void> _onDeleteSerie(
    DeleteSerie event,
    Emitter<SerieState> emit,
  ) async {
    try {
      await _isarService.deleteSerie(event.id);
      add(LoadSeries());
    } catch (e) {
      emit(SerieError('Erro ao excluir serie: $e'));
    }
  }
}
