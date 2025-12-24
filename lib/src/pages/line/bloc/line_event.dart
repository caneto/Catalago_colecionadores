import 'package:catalago_colecionadores/src/core/database/isar_models/line_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:isar_community/isar.dart';

abstract class LineEvent extends Equatable {
  const LineEvent();

  @override
  List<Object?> get props => [];
}

class LoadLines extends LineEvent {}

class AddLine extends LineEvent {
  final LineCollection line;

  const AddLine(this.line);

  @override
  List<Object?> get props => [line];
}

class DeleteLine extends LineEvent {
  final Id id;

  const DeleteLine(this.id);

  @override
  List<Object?> get props => [id];
}
