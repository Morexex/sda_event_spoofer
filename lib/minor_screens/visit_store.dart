import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

class VisitStore extends StatefulWidget {
  const VisitStore({super.key});

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Store',
        ),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
