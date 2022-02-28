import 'package:json_annotation/json_annotation.dart';
import 'package:onlyone/Core/DateTime+.dart';
import 'package:onlyone/models/enum/certification_cycle.dart';
import 'package:onlyone/models/enum/challenge_status.dart';
import 'package:onlyone/models/enum/character_type.dart';
import 'package:onlyone/models/feed_response.dart';
import 'package:onlyone/models/book.dart';
import 'current_member_status_response.dart';

part 'challenge_response.g.dart';

@JsonSerializable()
class ChallengeResponse {
  ChallengeResponse(
    this.challengeId,
    this.createMemberId,
    this.createMemberName,
    this.groupSize,
    this.challengeName,
    this.description,
    this.startDate,
    this.endDate,
    this.recruitDate,
    this.certificationCycle,
    this.characterType,
    this.currentMemberSize,
    this.certificationCount,
    this.challengeStatus,
    this.currentMemberStatusResponse,
    this.bookResponse,
    this.photoUrlList,
    this.feeds,
  );

  int challengeId;
  int createMemberId;
  String? createMemberName;
  int groupSize;
  String challengeName;
  String description;
  DateTime startDate;
  DateTime endDate;
  DateTime recruitDate;
  CertificationCycle certificationCycle;
  CharacterType characterType;
  int currentMemberSize;
  int certificationCount;
  ChallengeStatus challengeStatus;
  CurrentMemberStatusResponse currentMemberStatusResponse;
  Book bookResponse;
  List<String> photoUrlList;
  List<FeedResponse> feeds;

  bool get isEnded {
    return dDayEnd <= 0;
  }

  int get dDayEnd {
    final today = DateTime.now().removedTime();
    return endDate.removedTime().difference(today).inDays;
  }

  int get dDayStart {
    final today = DateTime.now().removedTime();
    return startDate.removedTime().difference(today).inDays;
  }

  String period() {
    final day = endDate.difference(startDate).inDays;
    if (day / 7 > 1) {
      final week = day ~/ 7;
      return "$week주";
    } else {
      return "$day일";
    }
  }

  String get cycleString => certificationCycle.getString();
  String get typeString => characterType.getString();

  factory ChallengeResponse.fromJson(Map<String, dynamic> json) =>
      _$ChallengeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeResponseToJson(this);
}
