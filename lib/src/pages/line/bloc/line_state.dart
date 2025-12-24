import 'package:catalago_colecionadores/src/core/database/isar_models/line_collection.dart';
import 'package:equatable/equatable.dart';

abstract class LineState extends Equatable {
  const LineState();

  @override
  List<Object> get props => [];
}

class LineInitial extends LineState {}

class LineLoading extends LineState {}

class LineLoaded extends LineState {
  final List<LineCollection> lines;

  const LineLoaded(this.lines);

  @override
  List<Object> get props => [lines];
}

class LineOperationSuccess extends LineState {
  final String message;

  const LineOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class LineError extends LineState {
  final String message;

  const LineError(this.message);

  @override
  List<Object> get props => [message];
}
