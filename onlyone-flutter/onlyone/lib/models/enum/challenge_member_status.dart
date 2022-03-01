import 'package:json_annotation/json_annotation.dart';

enum ChallengeMemberStatus {
  @JsonValue("NONE")
  NONE,
  @JsonValue("SUCCESS")
  SUCCESS,
  @JsonValue("FAIL")
  FAIL,
}
