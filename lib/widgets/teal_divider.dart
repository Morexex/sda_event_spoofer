import 'package:flutter/material.dart';

class PurpleDivider extends StatelessWidget {
  const PurpleDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.teal,
        thickness: 2,
      ),
    );
  }
}
