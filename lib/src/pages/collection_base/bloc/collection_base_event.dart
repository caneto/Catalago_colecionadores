part of 'collection_base_bloc.dart';

abstract class CollectionBaseEvent {}

class LoadCollectionBase extends CollectionBaseEvent {}

class AddCollectionBase extends CollectionBaseEvent {
  final CarBaseCollection collectionBase;
  final List<String>? images;
  AddCollectionBase(this.collectionBase, {this.images});
}

class DeleteCollectionBase extends CollectionBaseEvent {
  final int id;
  DeleteCollectionBase(this.id);
}
