import 'package:flutter/material.dart';

import '../../widgets/appbar_widgets.dart';

class GeneralTicketsScreen extends StatelessWidget {
  const GeneralTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'My Tickets',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
