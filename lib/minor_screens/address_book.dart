import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../widgets/appbar_widgets.dart';
import '../widgets/repeated_button_widget.dart';
import 'add_address.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({super.key});

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final Stream<QuerySnapshot> addressStream = FirebaseFirestore.instance
      .collection('genusers')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('address')
      .snapshots();

  Future dfAddressFalse(dynamic item) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('genusers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('address')
          .doc(item.id);
      transaction.update(documentReference, {'default': false});
    });
  }

  Future dfAddressTrue(dynamic customer) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('genusers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('address')
          .doc(customer['addressid']);
      transaction.update(documentReference, {'default': true});
    });
  }

  Future updateProfileAddPho(dynamic customer) async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('genusers')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'address':
            '${customer['country']} - ${customer['state']} -${customer['city']}',
        'phone': customer['phone']
      });
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
        title: const AppBarTitle(title: 'Address Book'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: addressStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'You didn\'t set\n \n an address yet!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Acme',
                        letterSpacing: 1.5,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var customer = snapshot.data!.docs[index];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) async =>
                            await FirebaseFirestore.instance
                                .runTransaction((transaction) async {
                          DocumentReference docReference = FirebaseFirestore
                              .instance
                              .collection('genusers')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('address')
                              .doc(customer['addressid']);
                          transaction.delete(docReference);
                        }),
                        child: GestureDetector(
                          onTap: () async {
                            showProgress();
                            for (var item in snapshot.data!.docs) {
                              await dfAddressFalse(item);
                            }
                            await dfAddressTrue(customer)
                                .whenComplete(() async =>
                                    await updateProfileAddPho(customer))
                                .whenComplete(() => Navigator.pop(context));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: customer['default'] == true
                                  ? Colors.indigo
                                  : Colors.purple,
                              child: ListTile(
                                trailing: customer['default'] == true
                                    ? const Icon(Icons.home)
                                    : const SizedBox(),
                                title: SizedBox(
                                  height: 50,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${customer['fname']} ~${customer['lname']}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text(customer['phone'],
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                                subtitle: SizedBox(
                                  height: 70,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'City/Town: '
                                        '${customer['city']} -${customer['state']}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      Text('Country: ' '${customer['country']}',
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          RepeatedButton(
              label: 'Add New Address',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAddress()));
              },
              width: 0.8),
          const SizedBox(
            height: 30,
          )
        ],
      )),
    );
  }
}