import 'package:json_annotation/json_annotation.dart';

part 'update_member_name.g.dart';

@JsonSerializable()
class UpdateMemberName {
  UpdateMemberName({
    required this.displayName,
  });
  String displayName;

  factory UpdateMemberName.fromJson(Map<String, dynamic> json) =>
      _$UpdateMemberNameFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMemberNameToJson(this);
}
