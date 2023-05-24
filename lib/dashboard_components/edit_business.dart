import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

class BusinessProfileScreen extends StatelessWidget {
  const BusinessProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Edit Business Profile',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
