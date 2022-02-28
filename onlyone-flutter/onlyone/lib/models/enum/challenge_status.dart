import 'package:json_annotation/json_annotation.dart';

enum ChallengeStatus {
  @JsonValue("RECRUIT")
  RECRUIT,
  @JsonValue("ACTIVE")
  ACTIVE,
  @JsonValue("FINISHED")
  FINISHED,
}
