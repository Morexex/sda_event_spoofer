import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BigText extends StatelessWidget {
  final Color color;
  final String text;
  double size;
  double maxLines;
  TextOverflow overflow;
  BigText({
    super.key,
    required this.color,
    required this.text,
    this.overflow = TextOverflow.ellipsis,
    this.size = 20,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(color: color,fontWeight: FontWeight.w400,fontFamily: 'Acme',fontSize: size),
    );
  }
}
