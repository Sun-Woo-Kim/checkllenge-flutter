// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge_result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChallengeResultResponse _$ChallengeResultResponseFromJson(
    Map<String, dynamic> json) {
  return ChallengeResultResponse(
    json['challengeId'] as int,
    json['memberId'] as int,
    json['certificationCount'] as int,
    json['certificationTotalCount'] as int,
    json['certificationRate'] as String,
    _$enumDecode(_$ChallengeMemberStatusEnumMap, json['challengeMemberStatus']),
  );
}

Map<String, dynamic> _$ChallengeResultResponseToJson(
        ChallengeResultResponse instance) =>
    <String, dynamic>{
      'challengeId': instance.challengeId,
      'memberId': instance.memberId,
      'certificationCount': instance.certificationCount,
      'certificationTotalCount': instance.certificationTotalCount,
      'certificationRate': instance.certificationRate,
      'challengeMemberStatus':
          _$ChallengeMemberStatusEnumMap[instance.challengeMemberStatus],
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

const _$ChallengeMemberStatusEnumMap = {
  ChallengeMemberStatus.NONE: 'NONE',
  ChallengeMemberStatus.SUCCESS: 'SUCCESS',
  ChallengeMemberStatus.FAIL: 'FAIL',
};
