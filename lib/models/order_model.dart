import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/repeated_button_widget.dart';

class CustomerOrderModel extends StatefulWidget {
  final dynamic order;
  const CustomerOrderModel({super.key, this.order});

  @override
  State<CustomerOrderModel> createState() => _CustomerOrderModelState();
}

class _CustomerOrderModelState extends State<CustomerOrderModel> {
  late double rate;
  late String comment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.purple),
            borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          title: Container(
            constraints: const BoxConstraints(maxHeight: 80),
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxHeight: 80, maxWidth: 80),
                    child: Image.network(widget.order['orderimage']),
                  ),
                ),
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order['odername'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(('Ksh ') +
                              (widget.order['orderprice'].toStringAsFixed(2))),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('see more..'),
              Text(widget.order['deliverystatus']),
            ],
          ),
          children: [
            Container(
              //height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: widget.order['deliverystatus'] == 'delivered'
                      ? Colors.orange.shade300
                      : Colors.purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ('Name: ') + (widget.order['custname']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Phone No: ') + (widget.order['phone']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Email Address: ') + (widget.order['email']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        ('Address: ') + (widget.order['address']),
                        style: const TextStyle(fontSize: 15),
                      ),
                      Row(
                        children: [
                          const Text(
                            ('Payment Status: '),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            (widget.order['paymentstaus']),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.green),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            ('Delivery Status: '),
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(
                            (widget.order['deliverystatus']),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.red),
                          ),
                        ],
                      ),
                      widget.order['deliverystatus'] == 'finalizing'
                          ? Text(
                              ('Estimated Delivery Date: ') +
                                  (DateFormat('yyyy-MM-dd').format(widget
                                          .order['deliverydate']
                                          .toDate()))
                                      .toString(),
                              style: const TextStyle(fontSize: 15))
                          : const Text(''),
                      widget.order['deliverystatus'] == 'delivered' &&
                              widget.order['orderreview'] == false
                          ? TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => Material(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 100,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                RatingBar.builder(
                                                  initialRating: 1,
                                                  minRating: 1,
                                                  allowHalfRating: true,
                                                  itemBuilder: (context, _) {
                                                    return const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    );
                                                  },
                                                  onRatingUpdate: ((value) {
                                                    rate = value;
                                                  }),
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Your review',
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.amber,
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  onChanged: (value) {
                                                    comment = value;
                                                  },
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    RepeatedButton(
                                                        label: 'Cancel',
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        width: 0.3),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    RepeatedButton(
                                                        label: 'Rate',
                                                        onPressed: () async {
                                                          CollectionReference
                                                              collReff =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'services')
                                                                  .doc(widget
                                                                          .order[
                                                                      'serid'])
                                                                  .collection(
                                                                      'reviews');
                                                          await collReff
                                                              .doc(FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid)
                                                              .set({
                                                            'name':
                                                                widget.order[
                                                                    'custname'],
                                                            'email': widget
                                                                .order['email'],
                                                            'rate': rate,
                                                            'comment': comment,
                                                            'profileimage': widget
                                                                    .order[
                                                                'profileimage']
                                                          }).whenComplete(
                                                                  () async {
                                                            await FirebaseFirestore
                                                                .instance
                                                                .runTransaction(
                                                                    (transaction) async {
                                                              DocumentReference
                                                                  documentReference =
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'orders')
                                                                      .doc(widget
                                                                              .order[
                                                                          'orderid']);
                                                              transaction.update(
                                                                  documentReference,
                                                                  {
                                                                    'orderreview':
                                                                        true,
                                                                  });
                                                            });
                                                          });
                                                          await Future.delayed(
                                                                  const Duration(
                                                                      microseconds:
                                                                          100))
                                                              .whenComplete(() =>
                                                                  Navigator.pop(
                                                                      context));
                                                        },
                                                        width: 0.3),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                              },
                              child: const Text('Write Review'))
                          : const Text(''),
                      widget.order['deliverystatus'] == 'delivered' &&
                              widget.order['orderreview'] == true
                          ? Row(
                              children: const [
                                Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Review Added',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.blue),
                                )
                              ],
                            )
                          : const Text('')
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}