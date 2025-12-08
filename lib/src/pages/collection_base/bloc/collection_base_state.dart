part of 'collection_base_bloc.dart';

abstract class CollectionBaseState {}

class CollectionBaseInitial extends CollectionBaseState {}

class CollectionBaseLoading extends CollectionBaseState {}

class CollectionBaseLoaded extends CollectionBaseState {
  final List<CarBaseCollection> collectionBaseList;
  CollectionBaseLoaded(this.collectionBaseList);
}

class CollectionBaseError extends CollectionBaseState {
  final String message;
  CollectionBaseError(this.message);
}

class CollectionBaseOperationSuccess extends CollectionBaseState {
  final String message;
  CollectionBaseOperationSuccess(this.message);
}
