import 'package:catalago_colecionadores/src/core/database/isar_models/serie_collection.dart';
import 'package:equatable/equatable.dart';

sealed class SerieEvent extends Equatable {
  const SerieEvent();

  @override
  List<Object?> get props => [];
}

final class LoadSeries extends SerieEvent {}

final class AddSerie extends SerieEvent {
  final SerieCollection serie;

  const AddSerie(this.serie);

  @override
  List<Object?> get props => [serie];
}

final class DeleteSerie extends SerieEvent {
  final int id;

  const DeleteSerie(this.id);

  @override
  List<Object?> get props => [id];
}
