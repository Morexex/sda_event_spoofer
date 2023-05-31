import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../providers/bookings_provider.dart';
import '../widgets/appbar_widgets.dart';
import '../widgets/repeated_button_widget.dart';

class PaymentScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String address;
  const PaymentScreen(
      {super.key,
      required this.name,
      required this.phone,
      required this.address});

  @override
  State<PaymentScreen> createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  final GlobalKey<ScaffoldMessengerState> scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  int selectedValue = 1;
  late String orderId;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('genusers');

  void showProgress() {
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(
      max: 100,
      msg: 'please wait!',
      progressBgColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = context.watch<Book>().totalPrice;
    double totalPaid = context.watch<Book>().totalPrice + 0;
    return FutureBuilder<DocumentSnapshot>(
        future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong!");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist!");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Material(
              color: Colors.grey.shade200,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.grey.shade200,
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.grey.shade200,
                    leading: const AppBarBackButton(),
                    title: const AppBarTitle(
                      title: 'Payment',
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      '${totalPaid.toStringAsFixed(2)} Ksh',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Total Order',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                    Text(
                                      '${totalPrice.toStringAsFixed(2)} Ksh',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                RadioListTile(
                                  value: 1,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title: const Text(
                                      'Payment upon task completion'),
                                  subtitle: const Text(
                                      'Pay when the task given is done'),
                                ),
                                RadioListTile(
                                  value: 2,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title:
                                      const Text('Pay via Visa / Master Card'),
                                  subtitle: Row(
                                    children: const [
                                      Icon(
                                        Icons.payment,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.ccMastercard,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.ccVisa,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                                RadioListTile(
                                    value: 3,
                                    groupValue: selectedValue,
                                    onChanged: (int? value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                    },
                                    title: const Text('Pay Via Paypal'),
                                    subtitle: Row(
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.paypal,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.ccPaypal,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    )),
                                RadioListTile(
                                  value: 4,
                                  groupValue: selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title: const Text('Pay Via Mpesa'),
                                  subtitle: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image(
                                            image: AssetImage(
                                                'images/inapp/mpesa.png')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottomSheet: Container(
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RepeatedButton(
                          label: 'Confirm ${totalPaid.toStringAsFixed(2)} Ksh',
                          onPressed: () {
                            if (selectedValue == 1) {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) => SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 100),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'Pay on Completion ${totalPaid.toStringAsFixed(2)} Ksh',
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                ),
                                              ),
                                              RepeatedButton(
                                                  label:
                                                      'Confirm ${totalPaid.toStringAsFixed(2)} Ksh',
                                                  onPressed: () async {
                                                    showProgress();
                                                    for (var item in context
                                                        .read<Book>()
                                                        .getItems) {
                                                      CollectionReference
                                                          orderRef =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'orders');
                                                      orderId =
                                                          const Uuid().v4();
                                                      await orderRef
                                                          .doc(orderId)
                                                          .set({
                                                        'gid': data['gid'],
                                                        'custname': widget.name,
                                                        'email': data['email'],
                                                        'address':
                                                            widget.address,
                                                        'phone': widget.phone,
                                                        'profileimage': data[
                                                            'profileimage'],
                                                        'sid': item.serId,
                                                        'serid':
                                                            item.documentId,
                                                        'orderid': orderId,
                                                        'odername': item.name,
                                                        'orderimage': item
                                                            .imagesUrl.first,
                                                        'orderprice':
                                                            item.price,
                                                        'deliverystatus':
                                                            'preparing',
                                                        'deliverydate': '',
                                                        'orderdate':
                                                            DateTime.now(),
                                                        'paymentstaus':
                                                            'Payment upon task completion',
                                                        'orderreview': false,
                                                      }).whenComplete(() async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .runTransaction(
                                                                (transaction) async {});
                                                      });
                                                    }
                                                    await Future.delayed(
                                                            const Duration())
                                                        .whenComplete(() {
                                                      context
                                                          .read<Book>()
                                                          .clearBook();
                                                      Navigator.popUntil(
                                                          context,
                                                          ModalRoute.withName(
                                                              '/general_home'));
                                                    });
                                                  },
                                                  width: 0.8)
                                            ],
                                          ),
                                        ),
                                      ));
                            } else if (selectedValue == 2) {
                              showModalBottomSheet(
                                context: context,
                                builder: ((context) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Developing in progress!!',
                                            style: TextStyle(
                                                fontSize: 35,
                                                color: Colors.teal),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            } else if (selectedValue == 3) {
                              showModalBottomSheet(
                                context: context,
                                builder: ((context) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Developing in progress!!',
                                            style: TextStyle(
                                                fontSize: 35,
                                                color: Colors.teal),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            } else if (selectedValue == 4) {
                              showModalBottomSheet(
                                context: context,
                                builder: ((context) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Developing in progress!!',
                                            style: TextStyle(
                                                fontSize: 35,
                                                color: Colors.teal),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            }
                          },
                          width: 1),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
