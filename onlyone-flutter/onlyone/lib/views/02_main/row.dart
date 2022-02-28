import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
//import 'package:onlyone/models/challenge_info.dart';
import 'package:onlyone/models/challenge_response.dart';
import 'package:onlyone/models/enum/challenge_status.dart';
import 'package:onlyone/views/components/image_view.dart';

class ChallengeRow extends StatelessWidget {
  final ChallengeResponse challenge;

  ChallengeRow(this.challenge);

  final double height = 150;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Container(
            height: height,
            color: Colors.white,
            child: _buildRow(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
            height: 1,
            color: ColorTheme.gray300,
          )
        ],
      ),
    );
  }

  Widget _buildRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(left: 16)),
        ImageView(
            imageURL: challenge.bookResponse.thumbnailImagePath,
            width: 100,
            height: height),
        Padding(padding: EdgeInsets.only(left: 16)),
        Expanded(
          flex: 2,
          child: _Description(challenge),
        ),
        Padding(padding: EdgeInsets.only(left: 16)),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description(this.challenge);

  final ChallengeResponse challenge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            challenge.challengeName,
            style: FontTheme.h4_with(ColorTheme.gray900),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
          Text(
            challenge.createMemberName ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: FontTheme.blockquote2_with(ColorTheme.gray800),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          const Padding(padding: EdgeInsets.only(top: 10)),
          _buildTypeView(),
          Spacer(),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          _buildStateText(),
        ],
      ),
    );
  }

  Widget _buildTypeView() {
    final list = [challenge.cycleString, challenge.period()];
    return SizedBox(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) => _buildRow(list[index]),
      ),
    );
  }

  Widget _buildRow(String text) {
    return Container(
      height: 28,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: EdgeInsets.only(right: 10),
      child: Text(
        text,
        style: FontTheme.blockquote2_with(ColorTheme.gray700),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        border: Border.all(width: 1.0, color: ColorTheme.gray700),
      ),
    );
  }

  Widget _buildStateText() {
    // "다 모이면(이 정보필요)", challenge.currentMemberSize,
    //           challenge.groupSize;
    switch (challenge.challengeStatus) {
      case ChallengeStatus.ACTIVE:
        return RichText(
          text: TextSpan(
            style: FontTheme.blockquote2_with(ColorTheme.sub500),
            children: <TextSpan>[
              TextSpan(
                  text: "D-${challenge.dDayEnd}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: " • ", style: TextStyle(color: ColorTheme.gray700)),
              TextSpan(
                  text: "${challenge.currentMemberSize}명",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      case ChallengeStatus.FINISHED:
        return RichText(
          text: TextSpan(
            style: FontTheme.blockquote2_with(ColorTheme.sub500),
            children: <TextSpan>[
              TextSpan(
                  text: "종료 • ${challenge.currentMemberSize}명",
                  style: TextStyle(
                      color: ColorTheme.gray700, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      case ChallengeStatus.RECRUIT:
        return RichText(
          text: TextSpan(
            style: FontTheme.blockquote2_with(ColorTheme.sub500),
            children: <TextSpan>[
              TextSpan(
                  text: "${challenge.dDayStart}일 뒤",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: " 시작", style: TextStyle(color: ColorTheme.gray900)),
              TextSpan(
                  text: " • ", style: TextStyle(color: ColorTheme.gray700)),
              TextSpan(
                  text: "${challenge.currentMemberSize}명",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                  text: " / ${challenge.groupSize}명",
                  style: TextStyle(color: ColorTheme.gray700)),
            ],
          ),
        );
    }
  }
}
