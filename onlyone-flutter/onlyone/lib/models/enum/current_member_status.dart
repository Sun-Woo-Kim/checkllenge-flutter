import 'package:json_annotation/json_annotation.dart';

enum CurrentMemberStatus {
  @JsonValue("NONE")
  NONE,
  @JsonValue("BELONG")
  BELONG,
  @JsonValue("CREATOR")
  CREATOR,
}
