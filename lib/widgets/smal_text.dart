import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  double maxLines;
  TextOverflow overflow;
  SmallText({
    super.key,
    this.color,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 15,
    this.height =1.2,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: overflow,
      style: TextStyle(color: color,fontWeight: FontWeight.w400,fontFamily: 'Acme',fontSize: size),
    );
  }
}
