import 'package:bloc/bloc.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';

import 'marca_event.dart';
import 'marca_state.dart';

class MarcaBloc extends Bloc<MarcaEvent, MarcaState> {
  final IsarService _isarService;

  MarcaBloc(this._isarService) : super(MarcaInitial()) {
    on<LoadMarcas>(_onLoadMarcas);
    on<AddMarca>(_onAddMarca);
    on<DeleteMarca>(_onDeleteMarca);
  }

  Future<void> _onLoadMarcas(LoadMarcas event, Emitter<MarcaState> emit) async {
    emit(MarcaLoading());
    try {
      final marcas = await _isarService.getAllMarcas();
      emit(MarcaLoaded(marcas));
    } catch (e) {
      emit(MarcaError('Erro ao carregar marcas: $e'));
    }
  }

  Future<void> _onAddMarca(AddMarca event, Emitter<MarcaState> emit) async {
    emit(MarcaLoading());
    try {
      await _isarService.saveMarca(event.marca);
      emit(const MarcaOperationSuccess('Marca salva com sucesso!'));
      add(LoadMarcas());
    } catch (e) {
      emit(MarcaError('Erro ao salvar marca: $e'));
    }
  }

  Future<void> _onDeleteMarca(
    DeleteMarca event,
    Emitter<MarcaState> emit,
  ) async {
    try {
      await _isarService.deleteMarca(event.id);
      add(LoadMarcas());
    } catch (e) {
      emit(MarcaError('Erro ao excluir marca: $e'));
    }
  }
}
