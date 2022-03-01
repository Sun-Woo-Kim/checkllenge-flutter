// 04_책린지상세_정보
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/models/challenge_response.dart';

import 'feeds/challenge_feed_total_view.dart';

class ChallengeDetailInfoView extends StatefulWidget {
  final ChallengeResponse challenge;

  const ChallengeDetailInfoView(this.challenge);
  @override
  _ChallengeDetailInfoViewState createState() =>
      _ChallengeDetailInfoViewState(challenge);
}

class _ChallengeDetailInfoViewState extends State<ChallengeDetailInfoView> {
  final ChallengeResponse challenge;

  _ChallengeDetailInfoViewState(this.challenge);
  @override
  Widget build(BuildContext context) {
    final book = challenge.bookResponse;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text("책정보", style: FontTheme.h2_with(ColorTheme.gray900)),
                SizedBox(height: 12),
                _Item("책제목", book.name),
                _Item("지은이", book.writer),
                _Item("출판사", book.publisher),
                SizedBox(height: 12),
                Container(color: ColorTheme.gray300, height: 1),
                Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "이 책의 전체 피드 보러가기",
                          style:
                              FontTheme.blockquote2_with(ColorTheme.point400),
                        ),
                        Image.asset("images/ic_arrow_s.png")
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChallengeFeedTotalView(book: book),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(color: ColorTheme.gray200, height: 8),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text("모임 정보", style: FontTheme.h2_with(ColorTheme.gray900)),
                SizedBox(height: 12),
                _Item("책린지기간", period()),
                _Item("인증 주기", challenge.cycleString),
                _Item("모임 성격", challenge.typeString),
                _Item("책린지리더", challenge.createMemberName ?? ""),
                _Item("크루 인원", challenge.currentMemberSize.toString() + "명"),
                SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String period() {
    final start = DateFormat("yyyy.MM.dd").format(challenge.startDate);
    final end = DateFormat("yyyy.MM.dd").format(challenge.endDate);
    return "$start ~ $end (${challenge.period()})";
  }
}

class _Item extends StatelessWidget {
  final String left;
  final String right;
  _Item(this.left, this.right);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 104,
                child: Text(left, style: FontTheme.p_with(ColorTheme.gray700)),
              ),
              Expanded(
                  child: Container(
                child: Text(right, style: FontTheme.p_with(ColorTheme.gray900)),
              )),
            ],
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
