part of 'collection_base_bloc.dart';

abstract class CollectionBaseEvent {}

class LoadCollectionBase extends CollectionBaseEvent {}

class AddCollectionBase extends CollectionBaseEvent {
  final CarBaseCollection collectionBase;
  AddCollectionBase(this.collectionBase);
}

class DeleteCollectionBase extends CollectionBaseEvent {
  final int id;
  DeleteCollectionBase(this.id);
}
