import 'package:catalago_colecionadores/src/core/database/isar_models/category_collection.dart';
import 'package:equatable/equatable.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCategories extends CategoryEvent {}

final class AddCategory extends CategoryEvent {
  final CategoryCollection category;

  const AddCategory(this.category);

  @override
  List<Object?> get props => [category];
}

final class DeleteCategory extends CategoryEvent {
  final int id;

  const DeleteCategory(this.id);

  @override
  List<Object?> get props => [id];
}
