// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marca_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMarcaCollectionCollection on Isar {
  IsarCollection<MarcaCollection> get marcaCollections => this.collection();
}

const MarcaCollectionSchema = CollectionSchema(
  name: r'MarcaCollection',
  id: -4434087507496796257,
  properties: {
    r'descricao': PropertySchema(
      id: 0,
      name: r'descricao',
      type: IsarType.string,
    ),
    r'images': PropertySchema(
      id: 1,
      name: r'images',
      type: IsarType.stringList,
    ),
    r'logo': PropertySchema(id: 2, name: r'logo', type: IsarType.string),
    r'nome': PropertySchema(id: 3, name: r'nome', type: IsarType.string),
    r'quantidade': PropertySchema(
      id: 4,
      name: r'quantidade',
      type: IsarType.long,
    ),
  },

  estimateSize: _marcaCollectionEstimateSize,
  serialize: _marcaCollectionSerialize,
  deserialize: _marcaCollectionDeserialize,
  deserializeProp: _marcaCollectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _marcaCollectionGetId,
  getLinks: _marcaCollectionGetLinks,
  attach: _marcaCollectionAttach,
  version: '3.3.0',
);

int _marcaCollectionEstimateSize(
  MarcaCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.descricao;
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
  {
    final value = object.logo;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.nome.length * 3;
  return bytesCount;
}

void _marcaCollectionSerialize(
  MarcaCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.descricao);
  writer.writeStringList(offsets[1], object.images);
  writer.writeString(offsets[2], object.logo);
  writer.writeString(offsets[3], object.nome);
  writer.writeLong(offsets[4], object.quantidade);
}

MarcaCollection _marcaCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MarcaCollection();
  object.descricao = reader.readStringOrNull(offsets[0]);
  object.id = id;
  object.images = reader.readStringList(offsets[1]);
  object.logo = reader.readStringOrNull(offsets[2]);
  object.nome = reader.readString(offsets[3]);
  object.quantidade = reader.readLongOrNull(offsets[4]);
  return object;
}

P _marcaCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _marcaCollectionGetId(MarcaCollection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _marcaCollectionGetLinks(MarcaCollection object) {
  return [];
}

void _marcaCollectionAttach(
  IsarCollection<dynamic> col,
  Id id,
  MarcaCollection object,
) {
  object.id = id;
}

extension MarcaCollectionQueryWhereSort
    on QueryBuilder<MarcaCollection, MarcaCollection, QWhere> {
  QueryBuilder<MarcaCollection, MarcaCollection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MarcaCollectionQueryWhere
    on QueryBuilder<MarcaCollection, MarcaCollection, QWhereClause> {
  QueryBuilder<MarcaCollection, MarcaCollection, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterWhereClause>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterWhereClause>
  idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterWhereClause> idBetween(
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

extension MarcaCollectionQueryFilter
    on QueryBuilder<MarcaCollection, MarcaCollection, QFilterCondition> {
  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'descricao'),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'descricao'),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'descricao',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'descricao',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'descricao',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'descricao', value: ''),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  descricaoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'descricao', value: ''),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'images'),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'images'),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'images', value: ''),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'images', value: ''),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', length, true, length, true);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', 0, true, 0, true);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', 0, false, 999999, true);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', 0, true, length, include);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  imagesLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(r'images', length, include, 999999, true);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
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

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'logo'),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'logo'),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'logo',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'logo',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'logo',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'logo', value: ''),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  logoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'logo', value: ''),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'nome',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'nome',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'nome',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  nomeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'nome', value: ''),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  quantidadeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'quantidade'),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  quantidadeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'quantidade'),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  quantidadeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'quantidade', value: value),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  quantidadeGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'quantidade',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  quantidadeLessThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'quantidade',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterFilterCondition>
  quantidadeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'quantidade',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MarcaCollectionQueryObject
    on QueryBuilder<MarcaCollection, MarcaCollection, QFilterCondition> {}

extension MarcaCollectionQueryLinks
    on QueryBuilder<MarcaCollection, MarcaCollection, QFilterCondition> {}

extension MarcaCollectionQuerySortBy
    on QueryBuilder<MarcaCollection, MarcaCollection, QSortBy> {
  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  sortByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  sortByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy> sortByLogo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  sortByLogoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo', Sort.desc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy> sortByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  sortByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  sortByQuantidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantidade', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  sortByQuantidadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantidade', Sort.desc);
    });
  }
}

extension MarcaCollectionQuerySortThenBy
    on QueryBuilder<MarcaCollection, MarcaCollection, QSortThenBy> {
  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  thenByDescricao() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  thenByDescricaoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'descricao', Sort.desc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy> thenByLogo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  thenByLogoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logo', Sort.desc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy> thenByNome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  thenByNomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nome', Sort.desc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  thenByQuantidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantidade', Sort.asc);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QAfterSortBy>
  thenByQuantidadeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantidade', Sort.desc);
    });
  }
}

extension MarcaCollectionQueryWhereDistinct
    on QueryBuilder<MarcaCollection, MarcaCollection, QDistinct> {
  QueryBuilder<MarcaCollection, MarcaCollection, QDistinct>
  distinctByDescricao({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'descricao', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QDistinct> distinctByImages() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'images');
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QDistinct> distinctByLogo({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QDistinct> distinctByNome({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nome', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MarcaCollection, MarcaCollection, QDistinct>
  distinctByQuantidade() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantidade');
    });
  }
}

extension MarcaCollectionQueryProperty
    on QueryBuilder<MarcaCollection, MarcaCollection, QQueryProperty> {
  QueryBuilder<MarcaCollection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MarcaCollection, String?, QQueryOperations> descricaoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'descricao');
    });
  }

  QueryBuilder<MarcaCollection, List<String>?, QQueryOperations>
  imagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'images');
    });
  }

  QueryBuilder<MarcaCollection, String?, QQueryOperations> logoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logo');
    });
  }

  QueryBuilder<MarcaCollection, String, QQueryOperations> nomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nome');
    });
  }

  QueryBuilder<MarcaCollection, int?, QQueryOperations> quantidadeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantidade');
    });
  }
}
