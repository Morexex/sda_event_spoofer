import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/main_screens/general_screens/general_screen.dart';

import '../widgets/appbar_widgets.dart';

class BookingScreen extends StatefulWidget {
  final Widget? back;
  const BookingScreen({super.key, this.back});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: widget.back,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: 'My Bookings'),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.black,
                  ))
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'No Current Bookings !',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 50,
                ),
                Material(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(15),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    onPressed: () {
                      Navigator.canPop(context)
                          ? Navigator.pop(context)
                          : Navigator.pushReplacementNamed(
                              context, '/general_home');
                    },
                    child: const Text(
                      'Explore Events',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Text(
                      'Total: Ksh ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '00:00',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(25)),
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: MaterialButton(
                      onPressed: () {},
                      child: const Text('Buy Ticket'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
