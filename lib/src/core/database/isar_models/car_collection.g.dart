// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCarCollectionCollection on Isar {
  IsarCollection<CarCollection> get carCollections => this.collection();
}

const CarCollectionSchema = CollectionSchema(
  name: r'CarCollection',
  id: -6052741701332649065,
  properties: {
    r'anoFabricacao': PropertySchema(
      id: 0,
      name: r'anoFabricacao',
      type: IsarType.long,
    ),
    r'categoria': PropertySchema(
      id: 1,
      name: r'categoria',
      type: IsarType.string,
    ),
    r'collectionCondition': PropertySchema(
      id: 2,
      name: r'collectionCondition',
      type: IsarType.string,
    ),
    r'condition': PropertySchema(
      id: 3,
      name: r'condition',
      type: IsarType.string,
    ),
    r'dataAquizicao': PropertySchema(
      id: 4,
      name: r'dataAquizicao',
      type: IsarType.dateTime,
    ),
    r'escala': PropertySchema(id: 5, name: r'escala', type: IsarType.string),
    r'imagePath': PropertySchema(
      id: 6,
      name: r'imagePath',
      type: IsarType.string,
    ),
    r'images': PropertySchema(
      id: 7,
      name: r'images',
      type: IsarType.stringList,
    ),
    r'marca': PropertySchema(id: 8, name: r'marca', type: IsarType.string),
    r'modelo': PropertySchema(id: 9, name: r'modelo', type: IsarType.string),
    r'nomeMiniatura': PropertySchema(
      id: 10,
      name: r'nomeMiniatura',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(id: 11, name: r'notes', type: IsarType.string),
    r'numeroCopias': PropertySchema(
      id: 12,
      name: r'numeroCopias',
      type: IsarType.long,
    ),
    r'numeroNaSerie': PropertySchema(
      id: 13,
      name: r'numeroNaSerie',
      type: IsarType.string,
    ),
    r'precoPago': PropertySchema(
      id: 14,
      name: r'precoPago',
      type: IsarType.double,
    ),
    r'serie': PropertySchema(id: 15, name: r'serie', type: IsarType.string),
  },

  estimateSize: _carCollectionEstimateSize,
  serialize: _carCollectionSerialize,
  deserialize: _carCollectionDeserialize,
  deserializeProp: _carCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _carCollectionGetId,
  getLinks: _carCollectionGetLinks,
  attach: _carCollectionAttach,
  version: '3.3.0',
);

int _carCollectionEstimateSize(
  CarCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.categoria.length * 3;
  {
    final value = object.collectionCondition;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.condition;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.escala.length * 3;
  {
    final value = object.imagePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final list = object.images;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.marca.length * 3;
  bytesCount += 3 + object.modelo.length * 3;
  bytesCount += 3 + object.nomeMiniatura.length * 3;
  {
    final value = object.notes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.numeroNaSerie;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.serie;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _carCollectionSerialize(
  CarCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.anoFabricacao);
  writer.writeString(offsets[1], object.categoria);
  writer.writeString(offsets[2], object.collectionCondition);
  writer.writeString(offsets[3], object.condition);
  writer.writeDateTime(offsets[4], object.dataAquizicao);
  writer.writeString(offsets[5], object.escala);
  writer.writeString(offsets[6], object.imagePath);
  writer.writeStringList(offsets[7], object.images);
  writer.writeString(offsets[8], object.marca);
  writer.writeString(offsets[9], object.modelo);
  writer.writeString(offsets[10], object.nomeMiniatura);
  writer.writeString(offsets[11], object.notes);
  writer.writeLong(offsets[12], object.numeroCopias);
  writer.writeString(offsets[13], object.numeroNaSerie);
  writer.writeDouble(offsets[14], object.precoPago);
  writer.writeString(offsets[15], object.serie);
}

CarCollection _carCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CarCollection();
  object.anoFabricacao = reader.readLongOrNull(offsets[0]);
  object.categoria = reader.readString(offsets[1]);
  object.collectionCondition = reader.readStringOrNull(offsets[2]);
  object.condition = reader.readStringOrNull(offsets[3]);
  object.dataAquizicao = reader.readDateTimeOrNull(offsets[4]);
  object.escala = reader.readString(offsets[5]);
  object.id = id;
  object.imagePath = reader.readStringOrNull(offsets[6]);
  object.images = reader.readStringList(offsets[7]);
  object.marca = reader.readString(offsets[8]);
  object.modelo = reader.readString(offsets[9]);
  object.nomeMiniatura = reader.readString(offsets[10]);
  object.notes = reader.readStringOrNull(offsets[11]);
  object.numeroCopias = reader.readLongOrNull(offsets[12]);
  object.numeroNaSerie = reader.readStringOrNull(offsets[13]);
  object.precoPago = reader.readDoubleOrNull(offsets[14]);
  object.serie = reader.readStringOrNull(offsets[15]);
  return object;
}

P _carCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringList(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readDoubleOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _carCollectionGetId(CarCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _carCollectionGetLinks(CarCollection object) {
  return [];
}

void _carCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  CarCollection object,
) {
  object.id = id;
}

extension CarCollectionQueryWhereSort
    on QueryBuilder<CarCollection, CarCollection, QWhere> {
  QueryBuilder<CarCollection, CarCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CarCollectionQueryWhere
    on QueryBuilder<CarCollection, CarCollection, QWhereClause> {
  QueryBuilder<CarCollection, CarCollection, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<CarCollection, CarCollection, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterWhereClause> idBetween(
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

extension CarCollectionQueryFilter
    on QueryBuilder<CarCollection, CarCollection, QFilterCondition> {
  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  anoFabricacaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'anoFabricacao'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  anoFabricacaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'anoFabricacao'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  anoFabricacaoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'anoFabricacao', value: value),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  anoFabricacaoGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'anoFabricacao',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  anoFabricacaoLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'anoFabricacao',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  anoFabricacaoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'anoFabricacao',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'categoria',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'categoria',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'categoria',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'categoria',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'categoria',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'categoria',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'categoria',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'categoria',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'categoria', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  categoriaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'categoria', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'collectionCondition'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'collectionCondition'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'collectionCondition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'collectionCondition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'collectionCondition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'collectionCondition',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'collectionCondition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'collectionCondition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'collectionCondition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'collectionCondition',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'collectionCondition', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  collectionConditionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'collectionCondition',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'condition'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'condition'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'condition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'condition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'condition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'condition',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'condition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'condition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'condition',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'condition',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'condition', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  conditionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'condition', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  dataAquizicaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'dataAquizicao'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  dataAquizicaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'dataAquizicao'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  dataAquizicaoEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'dataAquizicao', value: value),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  dataAquizicaoGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'dataAquizicao',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  dataAquizicaoLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'dataAquizicao',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  dataAquizicaoBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'dataAquizicao',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'escala',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'escala',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'escala',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'escala',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'escala',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'escala',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'escala',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'escala',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'escala', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  escalaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'escala', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
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

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
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

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'imagePath'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'imagePath'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'imagePath',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'imagePath',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'imagePath',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'imagePath', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'images'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'images'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'images',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'images',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'images',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'images',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'images',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'images',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'images',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'images',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'images', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'images', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', length, true, length, true);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', 0, true, 0, true);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', 0, false, 999999, true);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', 0, true, length, include);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', length, include, 999999, true);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  imagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'images',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'marca',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'marca',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'marca',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'marca', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  marcaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'marca', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'modelo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'modelo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'modelo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'modelo', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  modeloIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'modelo', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nomeMiniatura',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nomeMiniatura',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nomeMiniatura',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nomeMiniatura',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nomeMiniatura',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nomeMiniatura',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nomeMiniatura',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nomeMiniatura',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nomeMiniatura', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  nomeMiniaturaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nomeMiniatura', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'notes'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'notes',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'notes',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'notes',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'notes', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroCopiasIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'numeroCopias'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroCopiasIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'numeroCopias'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroCopiasEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'numeroCopias', value: value),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroCopiasGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'numeroCopias',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroCopiasLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'numeroCopias',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroCopiasBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'numeroCopias',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'numeroNaSerie'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'numeroNaSerie'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'numeroNaSerie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'numeroNaSerie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'numeroNaSerie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'numeroNaSerie',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'numeroNaSerie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'numeroNaSerie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'numeroNaSerie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'numeroNaSerie',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'numeroNaSerie', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  numeroNaSerieIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'numeroNaSerie', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  precoPagoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'precoPago'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  precoPagoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'precoPago'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  precoPagoEqualTo(double? value, {double epsilon = Query.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'precoPago',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  precoPagoGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'precoPago',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  precoPagoLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'precoPago',
          value: value,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  precoPagoBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'precoPago',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'serie'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'serie'),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'serie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'serie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'serie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'serie',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'serie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'serie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'serie',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'serie',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'serie', value: ''),
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterFilterCondition>
  serieIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'serie', value: ''),
      );
    });
  }
}

extension CarCollectionQueryObject
    on QueryBuilder<CarCollection, CarCollection, QFilterCondition> {}

extension CarCollectionQueryLinks
    on QueryBuilder<CarCollection, CarCollection, QFilterCondition> {}

extension CarCollectionQuerySortBy
    on QueryBuilder<CarCollection, CarCollection, QSortBy> {
  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByAnoFabricacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anoFabricacao', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByAnoFabricacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anoFabricacao', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByCollectionCondition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionCondition', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByCollectionConditionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionCondition', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByCondition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'condition', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByConditionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'condition', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByDataAquizicao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAquizicao', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByDataAquizicaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAquizicao', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByEscala() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escala', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByEscalaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escala', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByMarca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByMarcaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByModelo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByModeloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByNomeMiniatura() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeMiniatura', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByNomeMiniaturaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeMiniatura', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByNumeroCopias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCopias', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByNumeroCopiasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCopias', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByNumeroNaSerie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroNaSerie', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByNumeroNaSerieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroNaSerie', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortByPrecoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'precoPago', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  sortByPrecoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'precoPago', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortBySerie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serie', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> sortBySerieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serie', Sort.desc);
    });
  }
}

extension CarCollectionQuerySortThenBy
    on QueryBuilder<CarCollection, CarCollection, QSortThenBy> {
  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByAnoFabricacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anoFabricacao', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByAnoFabricacaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'anoFabricacao', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByCategoria() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByCategoriaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'categoria', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByCollectionCondition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionCondition', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByCollectionConditionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'collectionCondition', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByCondition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'condition', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByConditionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'condition', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByDataAquizicao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAquizicao', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByDataAquizicaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dataAquizicao', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByEscala() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escala', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByEscalaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escala', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByImagePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByImagePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePath', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByMarca() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByMarcaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marca', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByModelo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByModeloDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'modelo', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByNomeMiniatura() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeMiniatura', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByNomeMiniaturaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nomeMiniatura', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByNumeroCopias() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCopias', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByNumeroCopiasDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroCopias', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByNumeroNaSerie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroNaSerie', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByNumeroNaSerieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numeroNaSerie', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenByPrecoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'precoPago', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy>
  thenByPrecoPagoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'precoPago', Sort.desc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenBySerie() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serie', Sort.asc);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QAfterSortBy> thenBySerieDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serie', Sort.desc);
    });
  }
}

extension CarCollectionQueryWhereDistinct
    on QueryBuilder<CarCollection, CarCollection, QDistinct> {
  QueryBuilder<CarCollection, CarCollection, QDistinct>
  distinctByAnoFabricacao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'anoFabricacao');
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByCategoria({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'categoria', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct>
  distinctByCollectionCondition({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'collectionCondition',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByCondition({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'condition', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct>
  distinctByDataAquizicao() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dataAquizicao');
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByEscala({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'escala', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByImagePath({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByImages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'images');
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByMarca({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marca', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByModelo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'modelo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct>
  distinctByNomeMiniatura({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'nomeMiniatura',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByNotes({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct>
  distinctByNumeroCopias() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numeroCopias');
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct>
  distinctByNumeroNaSerie({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'numeroNaSerie',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctByPrecoPago() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'precoPago');
    });
  }

  QueryBuilder<CarCollection, CarCollection, QDistinct> distinctBySerie({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serie', caseSensitive: caseSensitive);
    });
  }
}

extension CarCollectionQueryProperty
    on QueryBuilder<CarCollection, CarCollection, QQueryProperty> {
  QueryBuilder<CarCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CarCollection, int?, QQueryOperations> anoFabricacaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'anoFabricacao');
    });
  }

  QueryBuilder<CarCollection, String, QQueryOperations> categoriaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'categoria');
    });
  }

  QueryBuilder<CarCollection, String?, QQueryOperations>
  collectionConditionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'collectionCondition');
    });
  }

  QueryBuilder<CarCollection, String?, QQueryOperations> conditionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'condition');
    });
  }

  QueryBuilder<CarCollection, DateTime?, QQueryOperations>
  dataAquizicaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dataAquizicao');
    });
  }

  QueryBuilder<CarCollection, String, QQueryOperations> escalaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'escala');
    });
  }

  QueryBuilder<CarCollection, String?, QQueryOperations> imagePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePath');
    });
  }

  QueryBuilder<CarCollection, List<String>?, QQueryOperations>
  imagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'images');
    });
  }

  QueryBuilder<CarCollection, String, QQueryOperations> marcaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marca');
    });
  }

  QueryBuilder<CarCollection, String, QQueryOperations> modeloProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'modelo');
    });
  }

  QueryBuilder<CarCollection, String, QQueryOperations>
  nomeMiniaturaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nomeMiniatura');
    });
  }

  QueryBuilder<CarCollection, String?, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<CarCollection, int?, QQueryOperations> numeroCopiasProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroCopias');
    });
  }

  QueryBuilder<CarCollection, String?, QQueryOperations>
  numeroNaSerieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numeroNaSerie');
    });
  }

  QueryBuilder<CarCollection, double?, QQueryOperations> precoPagoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'precoPago');
    });
  }

  QueryBuilder<CarCollection, String?, QQueryOperations> serieProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serie');
    });
  }
}
