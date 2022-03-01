// {
//   "code": "CHALLENGE_004",
//   "error": "ChallengeJoinFailsException",
//   "message": "챌린지 모집 인원이 가득 찼습니다.",
//   "path": "/api/challenge/apply",
//   "stacktrace": "com.bside.onlyone.core.challenge.exception.ChallengeJoinFailsException: 챌린지 모집 인원이 가득 찼습니다.\n\tat com.bside.onlyone.core.challenge.domain.Challenge.apply(Challenge.java:119)\n\tat com.bside.onlyone.core.challenge.application.ChallengeApplicationService.applyChallenge(ChallengeApplicationService.java:149)\n\tat com.bside.onlyone.core.challenge.application.ChallengeApplicationService$$FastClassBySpringCGLIB$$6643b86.invoke(<generated>)\n\tat org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)"
// }

import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  ErrorModel(
    this.code,
    this.error,
    this.message,
    this.path,
    this.stacktrace,
  );

  String? code;
  String? error;
  String? message;
  String? path;
  String? stacktrace;

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
