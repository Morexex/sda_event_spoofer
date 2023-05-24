import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/dashboard_components/services_orders.dart';
import 'package:sda_event_spoofer/dashboard_components/supplier_statics.dart';
import '../widgets/appbar_widgets.dart';
import '../main_screens/welcome_screen.dart';
import 'balance.dart';
import 'edit_business.dart';
import 'manage_services.dart';
import 'my_store.dart';

List<String> label = [
  'My Store',
  'orders',
  'edit profile',
  'manage products',
  'balance',
  'statics'
];
List<IconData> icons = [
  Icons.store,
  Icons.shop_2_outlined,
  Icons.edit,
  Icons.settings,
  Icons.attach_money,
  Icons.show_chart,
];

List<Widget> pages = [
  
  const MyStoreScreen(),
  const ServicesOrdersScreen(),
  const BusinessProfileScreen(),
  const ManageServicesScreen(),
  const SupplierBalanceScreen(),
  const SupplierStaticsScreen(),
];

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Dashboard',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/welcome_screen');
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: GridView.count(
          mainAxisSpacing: 50,
          crossAxisSpacing: 50,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              child: Card(
                elevation: 20,
                shadowColor: Colors.yellowAccent.shade200,
                color: Colors.blueGrey.withOpacity(0.7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      icons[index],
                      color: Colors.amber,
                      size: 50,
                    ),
                    Text(
                      label[index].toLowerCase(),
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.amber,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Acme'),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
