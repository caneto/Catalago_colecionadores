import 'package:bloc/bloc.dart';
import 'package:catalago_colecionadores/src/core/database/isar_models/car_base_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

part 'collection_base_event.dart';
part 'collection_base_state.dart';

class CollectionBaseBloc
    extends Bloc<CollectionBaseEvent, CollectionBaseState> {
  final IsarService _isarService;

  CollectionBaseBloc(this._isarService) : super(CollectionBaseInitial()) {
    on<LoadCollectionBase>(_onLoadCollectionBase);
    on<AddCollectionBase>(_onAddCollectionBase);
    on<DeleteCollectionBase>(_onDeleteCollectionBase);
  }

  Future<void> _onLoadCollectionBase(
    LoadCollectionBase event,
    Emitter<CollectionBaseState> emit,
  ) async {
    emit(CollectionBaseLoading());
    try {
      final collectionBaseList = await _isarService.getAllCarsBase();
      emit(CollectionBaseLoaded(collectionBaseList));
    } catch (e) {
      emit(CollectionBaseError('Erro ao carregar coleção base: $e'));
    }
  }

  Future<void> _onAddCollectionBase(
    AddCollectionBase event,
    Emitter<CollectionBaseState> emit,
  ) async {
    emit(CollectionBaseLoading());
    try {
      final ParseCloudFunction function = ParseCloudFunction(
        'v1-save-car-base',
      );
      final Map<String, dynamic> params = <String, dynamic>{
        'nomeMiniatura': event.collectionBase.nomeMiniatura,
        'categoria': event.collectionBase.categoria,
        'marca': event.collectionBase.marca,
        'modelo': event.collectionBase.modelo,
        'anoFabricacao': event.collectionBase.anoFabricacao,
        'escala': event.collectionBase.escala,
        'notes': event.collectionBase.notes,
      };

      final ParseResponse parseResponse = await function.execute(
        parameters: params,
      );

      if (parseResponse.success) {
        // Log success if needed, or handle response data
      }

      await _isarService.saveCarBase(event.collectionBase);
      emit(CollectionBaseOperationSuccess('Item salvo com sucesso!'));
      add(LoadCollectionBase());
    } catch (e) {
      emit(CollectionBaseError('Erro ao salvar item: $e'));
    }
  }

  Future<void> _onDeleteCollectionBase(
    DeleteCollectionBase event,
    Emitter<CollectionBaseState> emit,
  ) async {
    try {
      await _isarService.deleteCarBase(event.id);
      add(LoadCollectionBase());
    } catch (e) {
      emit(CollectionBaseError('Erro ao excluir item: $e'));
    }
  }
}
