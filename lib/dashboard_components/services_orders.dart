import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

class ServicesOrdersScreen extends StatelessWidget {
  const ServicesOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Services Orders',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
