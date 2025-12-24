// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_base_collection_favorite.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCarBaseCollectionFavoriteCollection on Isar {
  IsarCollection<CarBaseCollectionFavorite> get carBaseCollectionFavorites =>
      this.collection();
}

const CarBaseCollectionFavoriteSchema = CollectionSchema(
  name: r'CarBaseCollectionFavorite',
  id: -4229167469798440198,
  properties: {
    r'carBaseId': PropertySchema(
      id: 0,
      name: r'carBaseId',
      type: IsarType.long,
    ),
    r'isFavorite': PropertySchema(
      id: 1,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
  },

  estimateSize: _carBaseCollectionFavoriteEstimateSize,
  serialize: _carBaseCollectionFavoriteSerialize,
  deserialize: _carBaseCollectionFavoriteDeserialize,
  deserializeProp: _carBaseCollectionFavoriteDeserializeProp,
  idName: r'id',
  indexes: {
    r'carBaseId': IndexSchema(
      id: 9193610175734131674,
      name: r'carBaseId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'carBaseId',
          type: IndexType.value,
          caseSensitive: false,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},

  getId: _carBaseCollectionFavoriteGetId,
  getLinks: _carBaseCollectionFavoriteGetLinks,
  attach: _carBaseCollectionFavoriteAttach,
  version: '3.3.0',
);

int _carBaseCollectionFavoriteEstimateSize(
  CarBaseCollectionFavorite object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _carBaseCollectionFavoriteSerialize(
  CarBaseCollectionFavorite object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.carBaseId);
  writer.writeBool(offsets[1], object.isFavorite);
}

CarBaseCollectionFavorite _carBaseCollectionFavoriteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CarBaseCollectionFavorite();
  object.carBaseId = reader.readLong(offsets[0]);
  object.id = id;
  object.isFavorite = reader.readBool(offsets[1]);
  return object;
}

P _carBaseCollectionFavoriteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _carBaseCollectionFavoriteGetId(CarBaseCollectionFavorite object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _carBaseCollectionFavoriteGetLinks(
  CarBaseCollectionFavorite object,
) {
  return [];
}

void _carBaseCollectionFavoriteAttach(
  IsarCollection<dynamic> col,
  Id id,
  CarBaseCollectionFavorite object,
) {
  object.id = id;
}

extension CarBaseCollectionFavoriteByIndex
    on IsarCollection<CarBaseCollectionFavorite> {
  Future<CarBaseCollectionFavorite?> getByCarBaseId(int carBaseId) {
    return getByIndex(r'carBaseId', [carBaseId]);
  }

  CarBaseCollectionFavorite? getByCarBaseIdSync(int carBaseId) {
    return getByIndexSync(r'carBaseId', [carBaseId]);
  }

  Future<bool> deleteByCarBaseId(int carBaseId) {
    return deleteByIndex(r'carBaseId', [carBaseId]);
  }

  bool deleteByCarBaseIdSync(int carBaseId) {
    return deleteByIndexSync(r'carBaseId', [carBaseId]);
  }

  Future<List<CarBaseCollectionFavorite?>> getAllByCarBaseId(
    List<int> carBaseIdValues,
  ) {
    final values = carBaseIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'carBaseId', values);
  }

  List<CarBaseCollectionFavorite?> getAllByCarBaseIdSync(
    List<int> carBaseIdValues,
  ) {
    final values = carBaseIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'carBaseId', values);
  }

  Future<int> deleteAllByCarBaseId(List<int> carBaseIdValues) {
    final values = carBaseIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'carBaseId', values);
  }

  int deleteAllByCarBaseIdSync(List<int> carBaseIdValues) {
    final values = carBaseIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'carBaseId', values);
  }

  Future<Id> putByCarBaseId(CarBaseCollectionFavorite object) {
    return putByIndex(r'carBaseId', object);
  }

  Id putByCarBaseIdSync(
    CarBaseCollectionFavorite object, {
    bool saveLinks = true,
  }) {
    return putByIndexSync(r'carBaseId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCarBaseId(List<CarBaseCollectionFavorite> objects) {
    return putAllByIndex(r'carBaseId', objects);
  }

  List<Id> putAllByCarBaseIdSync(
    List<CarBaseCollectionFavorite> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'carBaseId', objects, saveLinks: saveLinks);
  }
}

extension CarBaseCollectionFavoriteQueryWhereSort
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QWhere
        > {
  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhere
  >
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhere
  >
  anyCarBaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'carBaseId'),
      );
    });
  }
}

extension CarBaseCollectionFavoriteQueryWhere
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QWhereClause
        > {
  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  carBaseIdEqualTo(int carBaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'carBaseId', value: [carBaseId]),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  carBaseIdNotEqualTo(int carBaseId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'carBaseId',
                lower: [],
                upper: [carBaseId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'carBaseId',
                lower: [carBaseId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'carBaseId',
                lower: [carBaseId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'carBaseId',
                lower: [],
                upper: [carBaseId],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  carBaseIdGreaterThan(int carBaseId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'carBaseId',
          lower: [carBaseId],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  carBaseIdLessThan(int carBaseId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'carBaseId',
          lower: [],
          upper: [carBaseId],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterWhereClause
  >
  carBaseIdBetween(
    int lowerCarBaseId,
    int upperCarBaseId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'carBaseId',
          lower: [lowerCarBaseId],
          includeLower: includeLower,
          upper: [upperCarBaseId],
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension CarBaseCollectionFavoriteQueryFilter
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QFilterCondition
        > {
  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  carBaseIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'carBaseId', value: value),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  carBaseIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'carBaseId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  carBaseIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'carBaseId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  carBaseIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'carBaseId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  idLessThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterFilterCondition
  >
  isFavoriteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isFavorite', value: value),
      );
    });
  }
}

extension CarBaseCollectionFavoriteQueryObject
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QFilterCondition
        > {}

extension CarBaseCollectionFavoriteQueryLinks
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QFilterCondition
        > {}

extension CarBaseCollectionFavoriteQuerySortBy
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QSortBy
        > {
  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  sortByCarBaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carBaseId', Sort.asc);
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  sortByCarBaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carBaseId', Sort.desc);
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }
}

extension CarBaseCollectionFavoriteQuerySortThenBy
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QSortThenBy
        > {
  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  thenByCarBaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carBaseId', Sort.asc);
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  thenByCarBaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'carBaseId', Sort.desc);
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<
    CarBaseCollectionFavorite,
    CarBaseCollectionFavorite,
    QAfterSortBy
  >
  thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }
}

extension CarBaseCollectionFavoriteQueryWhereDistinct
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QDistinct
        > {
  QueryBuilder<CarBaseCollectionFavorite, CarBaseCollectionFavorite, QDistinct>
  distinctByCarBaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'carBaseId');
    });
  }

  QueryBuilder<CarBaseCollectionFavorite, CarBaseCollectionFavorite, QDistinct>
  distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }
}

extension CarBaseCollectionFavoriteQueryProperty
    on
        QueryBuilder<
          CarBaseCollectionFavorite,
          CarBaseCollectionFavorite,
          QQueryProperty
        > {
  QueryBuilder<CarBaseCollectionFavorite, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CarBaseCollectionFavorite, int, QQueryOperations>
  carBaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'carBaseId');
    });
  }

  QueryBuilder<CarBaseCollectionFavorite, bool, QQueryOperations>
  isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }
}
