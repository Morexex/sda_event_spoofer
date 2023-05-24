import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/main_screens/main_event_page.dart';
import 'package:sda_event_spoofer/main_screens/service_providers/upload_screen.dart';
import 'package:sda_event_spoofer/main_screens/services_page.dart';
import '../events_page.dart';
import '../../dashboard_components/dashboard_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = const [
    MainEventPage(),
    EventsPageScreen(),
    ServicesPageScreen(),
    DashBoardScreen(),
    UploadProductScreen(),
  ] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.design_services), label: 'Services'),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'DashBoard'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload'),
        ],
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
