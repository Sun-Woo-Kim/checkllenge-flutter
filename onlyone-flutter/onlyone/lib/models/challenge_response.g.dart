// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeResponse _$ChallengeResponseFromJson(Map<String, dynamic> json) {
  return ChallengeResponse(
    json['challengeId'] as int,
    json['createMemberId'] as int,
    json['createMemberName'] as String?,
    json['groupSize'] as int,
    json['challengeName'] as String,
    json['description'] as String,
    DateTime.parse(json['startDate'] as String),
    DateTime.parse(json['endDate'] as String),
    DateTime.parse(json['recruitDate'] as String),
    _$enumDecode(_$CertificationCycleEnumMap, json['certificationCycle']),
    _$enumDecode(_$CharacterTypeEnumMap, json['characterType']),
    json['currentMemberSize'] as int,
    json['certificationCount'] as int,
    _$enumDecode(_$ChallengeStatusEnumMap, json['challengeStatus']),
    CurrentMemberStatusResponse.fromJson(
        json['currentMemberStatusResponse'] as Map<String, dynamic>),
    Book.fromJson(json['bookResponse'] as Map<String, dynamic>),
    (json['photoUrlList'] as List<dynamic>).map((e) => e as String).toList(),
    (json['feeds'] as List<dynamic>)
        .map((e) => FeedResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ChallengeResponseToJson(ChallengeResponse instance) =>
    <String, dynamic>{
      'challengeId': instance.challengeId,
      'createMemberId': instance.createMemberId,
      'createMemberName': instance.createMemberName,
      'groupSize': instance.groupSize,
      'challengeName': instance.challengeName,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'recruitDate': instance.recruitDate.toIso8601String(),
      'certificationCycle':
          _$CertificationCycleEnumMap[instance.certificationCycle],
      'characterType': _$CharacterTypeEnumMap[instance.characterType],
      'currentMemberSize': instance.currentMemberSize,
      'certificationCount': instance.certificationCount,
      'challengeStatus': _$ChallengeStatusEnumMap[instance.challengeStatus],
      'currentMemberStatusResponse': instance.currentMemberStatusResponse,
      'bookResponse': instance.bookResponse,
      'photoUrlList': instance.photoUrlList,
      'feeds': instance.feeds,
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

const _$ChallengeStatusEnumMap = {
  ChallengeStatus.RECRUIT: 'RECRUIT',
  ChallengeStatus.ACTIVE: 'ACTIVE',
  ChallengeStatus.FINISHED: 'FINISHED',
};
