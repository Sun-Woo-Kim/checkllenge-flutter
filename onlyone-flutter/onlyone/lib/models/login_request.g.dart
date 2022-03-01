// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return LoginRequest(
    uid: json['uid'] as String,
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    phoneNumber: json['phoneNumber'] as String,
    photoURL: json['photoURL'] as String,
    socialProvider: json['socialProvider'] as String,
    pushToken: json['pushToken'] as String,
    oldToken: json['oldToken'] as String,
    newToken: json['newToken'] as String,
    socialType: _$enumDecode(_$SocialTypeEnumMap, json['socialType']),
  );
}

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
      'socialProvider': instance.socialProvider,
      'pushToken': instance.pushToken,
      'oldToken': instance.oldToken,
      'newToken': instance.newToken,
      'socialType': _$SocialTypeEnumMap[instance.socialType],
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

const _$SocialTypeEnumMap = {
  SocialType.Google: 'Google',
  SocialType.Facebook: 'Facebook',
  SocialType.Apple: 'Apple',
  SocialType.Kakao: 'Kakao',
};
