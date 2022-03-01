// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateChallenge _$CreateChallengeFromJson(Map<String, dynamic> json) {
  return CreateChallenge(
    challengeName: json['challengeName'] as String,
    groupSize: json['groupSize'] as int,
    recruitTerm: _$enumDecode(_$RecruitTermEnumMap, json['recruitTerm']),
    readTerm: _$enumDecode(_$ReadTermEnumMap, json['readTerm']),
    certificationCycle:
        _$enumDecode(_$CertificationCycleEnumMap, json['certificationCycle']),
    characterType: _$enumDecode(_$CharacterTypeEnumMap, json['characterType']),
    description: json['description'] as String,
    book: BookRequest.fromJson(json['book'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CreateChallengeToJson(CreateChallenge instance) =>
    <String, dynamic>{
      'challengeName': instance.challengeName,
      'groupSize': instance.groupSize,
      'recruitTerm': _$RecruitTermEnumMap[instance.recruitTerm],
      'readTerm': _$ReadTermEnumMap[instance.readTerm],
      'certificationCycle':
          _$CertificationCycleEnumMap[instance.certificationCycle],
      'characterType': _$CharacterTypeEnumMap[instance.characterType],
      'description': instance.description,
      'book': instance.book,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$RecruitTermEnumMap = {
  RecruitTerm.AFTER_3_DAYS: 'AFTER_3_DAYS',
  RecruitTerm.AFTER_7_DAYS: 'AFTER_7_DAYS',
  RecruitTerm.ON_FULL: 'ON_FULL',
};

const _$ReadTermEnumMap = {
  ReadTerm.WEEK_OF_2: 'WEEK_OF_2',
  ReadTerm.WEEK_OF_4: 'WEEK_OF_4',
  ReadTerm.WEEK_OF_6: 'WEEK_OF_6',
  ReadTerm.WEEK_OF_8: 'WEEK_OF_8',
};

const _$CertificationCycleEnumMap = {
  CertificationCycle.NONE: 'NONE',
  CertificationCycle.ONCE_A_WEEK: 'ONCE_A_WEEK',
  CertificationCycle.TWICE_A_WEEK: 'TWICE_A_WEEK',
  CertificationCycle.THIRD_A_WEEK: 'THIRD_A_WEEK',
};

const _$CharacterTypeEnumMap = {
  CharacterType.HARD_CERTIFICATION: 'HARD_CERTIFICATION',
  CharacterType.WRITE_A_REVIEW: 'WRITE_A_REVIEW',
  CharacterType.DISCUSS_ACTIVELY: 'DISCUSS_ACTIVELY',
};
