import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/main_screens/main_event_page.dart';
import 'package:sda_event_spoofer/main_screens/profile.dart';
import 'package:sda_event_spoofer/main_screens/services_page.dart';

import '../bookings_page.dart';
import '../events_page.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = const [
    MainEventPage(),
    EventsPageScreen(),
    ServicesPageScreen(),
    BookingScreen(),
    ProfileScreen(),
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
              icon: Icon(Icons.book_online), label: 'My Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
