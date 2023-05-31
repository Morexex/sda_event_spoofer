import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_event_spoofer/minor_screens/place_order.dart';

import '../models/book_model.dart';
import '../providers/bookings_provider.dart';
import '../widgets/alert_dialogue.dart';
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
    late double total = context.watch<Book>().totalPrice;
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: widget.back,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: 'My Bookings'),
            actions: [
              context.watch<Book>().getItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialogue.showMyDialogue(
                            context: context,
                            title: 'Clear Bookings?',
                            content:
                                'Are you sure you want to clear your bookings?',
                            tabNo: () {
                              Navigator.pop(context);
                            },
                            tabYes: () {
                              context.read<Book>().clearBook();
                              Navigator.pop(context);
                            });
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.black,
                      ))
            ],
          ),
          body: context.watch<Book>().getItems.isNotEmpty
              ? const BookedServices()
              : const EmptyBookings(),
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Text(
                      'Total: \$ ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      total.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25)),
                  height: 35,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlaceOrderScreen()));
                    },
                    child: const Text('Buy Service'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class EmptyBookings extends StatelessWidget {
  const EmptyBookings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    : Navigator.pushReplacementNamed(context, '/general_home');
              },
              child: const Text(
                'Explore Events',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BookedServices extends StatelessWidget {
  const BookedServices({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Book>(
      builder: (context, book, child) {
        return ListView.builder(
            itemCount: book.count,
            itemBuilder: (context, index) {
              final service = book.getItems[index];
              return BookModel(
                service: service,
                book: context.read<Book>(),
              );
            });
      },
    );
  }
}
