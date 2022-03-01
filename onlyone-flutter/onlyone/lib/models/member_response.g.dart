// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberResponse _$MemberResponseFromJson(Map<String, dynamic> json) {
  return MemberResponse(
    json['displayName'] as String,
    json['email'] as String,
    json['photoURL'] as String,
    json['socialProvider'] as String,
    json['totalChallengeCount'] as int,
    json['finishedChallengeCount'] as int,
    json['successChallengeCount'] as int,
    json['successChallengePercent'] as String,
  );
}

Map<String, dynamic> _$MemberResponseToJson(MemberResponse instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'photoURL': instance.photoURL,
      'socialProvider': instance.socialProvider,
      'totalChallengeCount': instance.totalChallengeCount,
      'finishedChallengeCount': instance.finishedChallengeCount,
      'successChallengeCount': instance.successChallengeCount,
      'successChallengePercent': instance.successChallengePercent,
    };
