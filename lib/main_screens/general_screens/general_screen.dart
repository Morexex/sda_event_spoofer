import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_event_spoofer/main_screens/main_event_page.dart';
import 'package:sda_event_spoofer/main_screens/profile.dart';
import 'package:sda_event_spoofer/main_screens/services_page.dart';
import 'package:badges/badges.dart' as badges;
import '../../providers/bookings_provider.dart';
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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.event), label: 'Events'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.design_services), label: 'Services'),
          BottomNavigationBarItem(
            icon: badges.Badge(
                showBadge: context.read<Book>().getItems.isEmpty ? false : true,
                badgeStyle: const badges.BadgeStyle(badgeColor: Colors.amber),
                badgeContent: Text(
                  context.watch<Book>().getItems.length.toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                child: const Icon(Icons.book_online)),
            label: 'Bookings',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
