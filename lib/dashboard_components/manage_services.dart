import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

class ManageServicesScreen extends StatelessWidget {
  const ManageServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Manage Services',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
