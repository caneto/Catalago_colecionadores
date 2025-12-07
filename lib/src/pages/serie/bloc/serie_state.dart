import 'package:catalago_colecionadores/src/core/database/isar_models/serie_collection.dart';
import 'package:equatable/equatable.dart';

sealed class SerieState extends Equatable {
  const SerieState();

  @override
  List<Object?> get props => [];
}

final class SerieInitial extends SerieState {}

final class SerieLoading extends SerieState {}

final class SerieLoaded extends SerieState {
  final List<SerieCollection> series;

  const SerieLoaded(this.series);

  @override
  List<Object?> get props => [series];
}

final class SerieOperationSuccess extends SerieState {
  final String message;

  const SerieOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class SerieError extends SerieState {
  final String message;

  const SerieError(this.message);

  @override
  List<Object?> get props => [message];
}
