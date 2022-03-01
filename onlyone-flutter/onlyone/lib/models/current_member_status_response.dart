import 'package:json_annotation/json_annotation.dart';
import 'enum/current_member_status.dart';

part 'current_member_status_response.g.dart';

@JsonSerializable()
class CurrentMemberStatusResponse {
  CurrentMemberStatusResponse({
    required this.currentMemberStatus,
    required this.feedsCount,
  });

  CurrentMemberStatus currentMemberStatus;
  int feedsCount;

  factory CurrentMemberStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentMemberStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentMemberStatusResponseToJson(this);
}
