import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/dashboard_components/preparing_orders.dart';
import 'package:sda_event_spoofer/dashboard_components/finishing_orders.dart';

import '../widgets/appbar_widgets.dart';
import 'delivered_orders.dart';

class ServicesOrdersScreen extends StatelessWidget {
  const ServicesOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(),
          title: const AppBarTitle(
            title: 'Orders',
          ),
          bottom: const TabBar(
            indicatorColor: Colors.purple,
            indicatorWeight: 8,
            tabs: [
            RepeatedTab(label: 'Preparing'),
            RepeatedTab(label: 'Finishing'),
            RepeatedTab(label: 'Delivered'),
          ]),
        ),
        body: const TabBarView(children: [
          Preparing(),
          Finishing(),
          Delivered(),
        ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}