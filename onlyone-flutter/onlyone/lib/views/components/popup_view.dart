import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';
import 'package:onlyone/Core/font_theme.dart';

class PopupView extends StatelessWidget {
  final String? title;
  final String description;
  final String actionText;
  final void Function() action;

  bool hasTitle() {
    return title?.isNotEmpty ?? false;
  }

  PopupView(
      {this.title = "",
      this.description = "",
      required this.actionText,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      title: hasTitle() ? _title() : null,
      content: _description(),
      actions: [_action()],
      titlePadding: EdgeInsets.only(top: 40),
      contentPadding: EdgeInsets.only(top: hasTitle() ? 8 : 40, bottom: 16),
      insetPadding: EdgeInsets.all(0),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(16),
    );
  }

  _title() {
    return Container(
      child: Text(
        this.title ?? "",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorTheme.gray900,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  _description() {
    return Container(
      // padding: EdgeInsets.only(top: hasTitle() ? 0 : 40),
      child: Text(
        this.description,
        textAlign: TextAlign.center,
        style: FontTheme.p_with(ColorTheme.gray900),
      ),
    );
  }

  _action() {
    return Container(
      width: 248,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: ColorTheme.point400,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: TextButton(
          onPressed: this.action,
          child: Text(
            actionText,
            style: FontTheme.h5_with(Colors.white),
          )),
    );
  }
}
