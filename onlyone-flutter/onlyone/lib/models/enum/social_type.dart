import 'package:json_annotation/json_annotation.dart';

enum SocialType {
  @JsonValue("Google")
  Google,
  @JsonValue("Facebook")
  Facebook,
  @JsonValue("Apple")
  Apple,
  @JsonValue("Kakao")
  Kakao,
}
