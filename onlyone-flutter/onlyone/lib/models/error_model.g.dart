// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) {
  return ErrorModel(
    json['code'] as String?,
    json['error'] as String?,
    json['message'] as String?,
    json['path'] as String?,
    json['stacktrace'] as String?,
  );
}

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'error': instance.error,
      'message': instance.message,
      'path': instance.path,
      'stacktrace': instance.stacktrace,
    };
