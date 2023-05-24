import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

class SupplierStaticsScreen extends StatelessWidget {
  const SupplierStaticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Statics',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
