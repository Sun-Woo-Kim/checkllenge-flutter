import 'package:flutter/material.dart';
import 'package:onlyone/Core/color_theme.dart';

class ImageView extends StatelessWidget {
  final String imageURL;
  final double width;
  final double height;

  final bool shadow;

  ImageView({
    required this.imageURL,
    required this.width,
    required this.height,
    this.shadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: shadow ? buildShadow() : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FadeInImage.assetNetwork(
          placeholder: "images/img_default.png",
          image: imageURL,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  BoxDecoration buildShadow() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Color(0xff26000000),
          spreadRadius: 0,
          blurRadius: 8,
          offset: Offset(0, 4), // changes position of shadow
        ),
      ],
    );
  }
}
