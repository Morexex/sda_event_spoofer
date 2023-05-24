import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

class SupplierbalanceScreen extends StatelessWidget {
  const SupplierbalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Supplier Balance',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
