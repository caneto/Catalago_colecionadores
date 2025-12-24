import 'package:bloc/bloc.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';

import 'line_event.dart';
import 'line_state.dart';

class LineBloc extends Bloc<LineEvent, LineState> {
  final IsarService isarService;

  LineBloc(this.isarService) : super(LineInitial()) {
    on<LoadLines>(_onLoadLines);
    on<AddLine>(_onAddLine);
    on<DeleteLine>(_onDeleteLine);
  }

  Future<void> _onLoadLines(LoadLines event, Emitter<LineState> emit) async {
    emit(LineLoading());
    try {
      final lines = await isarService.getAllLines();
      emit(LineLoaded(lines));
    } catch (e) {
      emit(LineError("Erro ao carregar linhas: $e"));
    }
  }

  Future<void> _onAddLine(AddLine event, Emitter<LineState> emit) async {
    emit(LineLoading());
    try {
      await isarService.saveLine(event.line);
      emit(const LineOperationSuccess("Linha salva com sucesso!"));
      // Reload lines after saving
      add(LoadLines());
    } catch (e) {
      emit(LineError("Erro ao salvar linha: $e"));
    }
  }

  Future<void> _onDeleteLine(DeleteLine event, Emitter<LineState> emit) async {
    emit(LineLoading());
    try {
      await isarService.deleteLine(event.id);
      emit(const LineOperationSuccess("Linha removida com sucesso!"));
      add(LoadLines());
    } catch (e) {
      emit(LineError("Erro ao remover linha: $e"));
    }
  }
}
