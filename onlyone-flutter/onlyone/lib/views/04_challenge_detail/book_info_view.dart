import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';
import 'package:onlyone/models/challenge_response.dart';

import 'package:onlyone/views/components/image_view.dart';

class BookInfoView extends StatelessWidget {
  final ChallengeResponse challenge;
  BookInfoView(this.challenge);
  @override
  Widget build(BuildContext context) {
    var imageURL = challenge.bookResponse.thumbnailImagePath;

    final double imageHeight = 160;
    return Container(
      height: imageHeight,
      child: Row(
        children: [
          ImageView(
            imageURL: imageURL,
            width: 107,
            height: imageHeight,
          ),
          SizedBox(width: 16),
          Expanded(child: _Description(challenge)),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description(this.challenge);

  final ChallengeResponse challenge;

  @override
  Widget build(BuildContext context) {
    final book = challenge.bookResponse;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(book.name,
            maxLines: 3, style: FontTheme.h3_with(ColorTheme.gray900)),
        SizedBox(height: 8),
        _text("지은이", book.writer),
        SizedBox(height: 4),
        _text("출판사", book.publisher),
        Spacer(),
        _lastText()
      ],
    );
  }

  _text(String left, String right) {
    return Row(children: [
      Text(left, style: FontTheme.blockquote2_with(ColorTheme.gray700)),
      SizedBox(width: 8),
      Text(right, style: FontTheme.blockquote2_with(ColorTheme.gray900)),
    ]);
  }

  _lastText() {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: '',
            style: FontTheme.blockquote2_with(ColorTheme.gray900),
            children: <TextSpan>[
              TextSpan(
                  text: '${challenge.dDayStart}일',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' 뒤 시작'),
            ],
          ),
        ),
        SizedBox(width: 8),
        Container(width: 1, height: 12, color: Color(0xffc4c4c4)),
        SizedBox(width: 8),
        Text("${challenge.cycleString}",
            style: FontTheme.blockquote2_with(ColorTheme.gray900)),
      ],
    );
  }
}
