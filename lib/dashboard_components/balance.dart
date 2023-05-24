import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

class SupplierBalanceScreen extends StatelessWidget {
  const SupplierBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Balance',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
