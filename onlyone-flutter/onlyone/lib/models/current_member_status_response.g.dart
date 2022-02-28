// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_member_status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentMemberStatusResponse _$CurrentMemberStatusResponseFromJson(
    Map<String, dynamic> json) {
  return CurrentMemberStatusResponse(
    currentMemberStatus:
        _$enumDecode(_$CurrentMemberStatusEnumMap, json['currentMemberStatus']),
    feedsCount: json['feedsCount'] as int,
  );
}

Map<String, dynamic> _$CurrentMemberStatusResponseToJson(
        CurrentMemberStatusResponse instance) =>
    <String, dynamic>{
      'currentMemberStatus':
          _$CurrentMemberStatusEnumMap[instance.currentMemberStatus],
      'feedsCount': instance.feedsCount,
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

const _$CurrentMemberStatusEnumMap = {
  CurrentMemberStatus.NONE: 'NONE',
  CurrentMemberStatus.BELONG: 'BELONG',
  CurrentMemberStatus.CREATOR: 'CREATOR',
};
