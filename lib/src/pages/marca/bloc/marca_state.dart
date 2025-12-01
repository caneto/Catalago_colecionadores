import 'package:catalago_colecionadores/src/core/database/isar_models/marca_collection.dart';
import 'package:equatable/equatable.dart';

sealed class MarcaState extends Equatable {
  const MarcaState();

  @override
  List<Object?> get props => [];
}

final class MarcaInitial extends MarcaState {}

final class MarcaLoading extends MarcaState {}

final class MarcaLoaded extends MarcaState {
  final List<MarcaCollection> marcas;

  const MarcaLoaded(this.marcas);

  @override
  List<Object?> get props => [marcas];
}

final class MarcaOperationSuccess extends MarcaState {
  final String message;

  const MarcaOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class MarcaError extends MarcaState {
  final String message;

  const MarcaError(this.message);

  @override
  List<Object?> get props => [message];
}
