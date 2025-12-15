// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_collection_gallery.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCarCollectionGalleryCollection on Isar {
  IsarCollection<CarCollectionGallery> get carCollectionGallerys =>
      this.collection();
}

const CarCollectionGallerySchema = CollectionSchema(
  name: r'CarCollectionGallery',
  id: -2363613000472698174,
  properties: {
    r'imageBase64': PropertySchema(
      id: 0,
      name: r'imageBase64',
      type: IsarType.string,
    ),
  },

  estimateSize: _carCollectionGalleryEstimateSize,
  serialize: _carCollectionGallerySerialize,
  deserialize: _carCollectionGalleryDeserialize,
  deserializeProp: _carCollectionGalleryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'car': LinkSchema(
      id: 6971126169877883790,
      name: r'car',
      target: r'CarCollection',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _carCollectionGalleryGetId,
  getLinks: _carCollectionGalleryGetLinks,
  attach: _carCollectionGalleryAttach,
  version: '3.3.0',
);

int _carCollectionGalleryEstimateSize(
  CarCollectionGallery object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.imageBase64.length * 3;
  return bytesCount;
}

void _carCollectionGallerySerialize(
  CarCollectionGallery object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.imageBase64);
}

CarCollectionGallery _carCollectionGalleryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CarCollectionGallery();
  object.id = id;
  object.imageBase64 = reader.readString(offsets[0]);
  return object;
}

P _carCollectionGalleryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _carCollectionGalleryGetId(CarCollectionGallery object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _carCollectionGalleryGetLinks(
  CarCollectionGallery object,
) {
  return [object.car];
}

void _carCollectionGalleryAttach(
  IsarCollection<dynamic> col,
  Id id,
  CarCollectionGallery object,
) {
  object.id = id;
  object.car.attach(col, col.isar.collection<CarCollection>(), r'car', id);
}

extension CarCollectionGalleryQueryWhereSort
    on QueryBuilder<CarCollectionGallery, CarCollectionGallery, QWhere> {
  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterWhere>
  anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CarCollectionGalleryQueryWhere
    on QueryBuilder<CarCollectionGallery, CarCollectionGallery, QWhereClause> {
  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterWhereClause>
  idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterWhereClause>
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

  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterWhereClause>
  idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterWhereClause>
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
}

extension CarCollectionGalleryQueryFilter
    on
        QueryBuilder<
          CarCollectionGallery,
          CarCollectionGallery,
          QFilterCondition
        > {
  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
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
    CarCollectionGallery,
    CarCollectionGallery,
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
    CarCollectionGallery,
    CarCollectionGallery,
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
    CarCollectionGallery,
    CarCollectionGallery,
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
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64EqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'imageBase64',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'imageBase64',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'imageBase64',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'imageBase64',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64StartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'imageBase64',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64EndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'imageBase64',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64Contains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'imageBase64',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64Matches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'imageBase64',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imageBase64', value: ''),
      );
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  imageBase64IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'imageBase64', value: ''),
      );
    });
  }
}

extension CarCollectionGalleryQueryObject
    on
        QueryBuilder<
          CarCollectionGallery,
          CarCollectionGallery,
          QFilterCondition
        > {}

extension CarCollectionGalleryQueryLinks
    on
        QueryBuilder<
          CarCollectionGallery,
          CarCollectionGallery,
          QFilterCondition
        > {
  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  car(FilterQuery<CarCollection> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'car');
    });
  }

  QueryBuilder<
    CarCollectionGallery,
    CarCollectionGallery,
    QAfterFilterCondition
  >
  carIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'car', 0, true, 0, true);
    });
  }
}

extension CarCollectionGalleryQuerySortBy
    on QueryBuilder<CarCollectionGallery, CarCollectionGallery, QSortBy> {
  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterSortBy>
  sortByImageBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageBase64', Sort.asc);
    });
  }

  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterSortBy>
  sortByImageBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageBase64', Sort.desc);
    });
  }
}

extension CarCollectionGalleryQuerySortThenBy
    on QueryBuilder<CarCollectionGallery, CarCollectionGallery, QSortThenBy> {
  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterSortBy>
  thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterSortBy>
  thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterSortBy>
  thenByImageBase64() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageBase64', Sort.asc);
    });
  }

  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QAfterSortBy>
  thenByImageBase64Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageBase64', Sort.desc);
    });
  }
}

extension CarCollectionGalleryQueryWhereDistinct
    on QueryBuilder<CarCollectionGallery, CarCollectionGallery, QDistinct> {
  QueryBuilder<CarCollectionGallery, CarCollectionGallery, QDistinct>
  distinctByImageBase64({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageBase64', caseSensitive: caseSensitive);
    });
  }
}

extension CarCollectionGalleryQueryProperty
    on
        QueryBuilder<
          CarCollectionGallery,
          CarCollectionGallery,
          QQueryProperty
        > {
  QueryBuilder<CarCollectionGallery, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CarCollectionGallery, String, QQueryOperations>
  imageBase64Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageBase64');
    });
  }
}
