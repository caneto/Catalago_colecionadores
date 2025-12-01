import 'package:bloc/bloc.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';

import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final IsarService _isarService;

  CategoryBloc(this._isarService) : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final categories = await _isarService.getAllCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError('Erro ao carregar categorias: $e'));
    }
  }

  Future<void> _onAddCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      await _isarService.saveCategory(event.category);
      emit(const CategoryOperationSuccess('Categoria salva com sucesso!'));
      add(LoadCategories());
    } catch (e) {
      emit(CategoryError('Erro ao salvar categoria: $e'));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await _isarService.deleteCategory(event.id);
      add(LoadCategories());
    } catch (e) {
      emit(CategoryError('Erro ao excluir categoria: $e'));
    }
  }
}
