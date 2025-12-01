import 'package:catalago_colecionadores/src/core/database/isar_models/marca_collection.dart';
import 'package:equatable/equatable.dart';

sealed class MarcaEvent extends Equatable {
  const MarcaEvent();

  @override
  List<Object?> get props => [];
}

final class LoadMarcas extends MarcaEvent {}

final class AddMarca extends MarcaEvent {
  final MarcaCollection marca;

  const AddMarca(this.marca);

  @override
  List<Object?> get props => [marca];
}

final class DeleteMarca extends MarcaEvent {
  final int id;

  const DeleteMarca(this.id);

  @override
  List<Object?> get props => [id];
}
