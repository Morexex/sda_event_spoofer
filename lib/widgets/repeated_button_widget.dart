import 'package:flutter/material.dart';

class RepeatedButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;
  const RepeatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(25)),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(label,style: const TextStyle(color: Colors.white),),
        ));
  }
}
