import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/bookings_provider.dart';
import '../providers/mychoice_provider.dart';
import '../providers/service_provider.dart';

class BookModel extends StatelessWidget {
  const BookModel({
    super.key,
    required this.service,
    required this.book,
  });

  final Service service;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(children: [
            SizedBox(
              height: 100,
              width: 120,
              child: Image.network(service.imagesUrl.first),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      service.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          service.price.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showCupertinoModalPopup<void>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            CupertinoActionSheet(
                                              title: const Text(
                                                'Remove service!',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              message: const Text(
                                                'Are you sure you want to remove this service from bookings?',
                                                style: TextStyle(fontSize: 25),
                                              ),
                                              actions: <
                                                  CupertinoActionSheetAction>[
                                                CupertinoActionSheetAction(
                                                  isDefaultAction: true,
                                                  onPressed: () async {
                                                    context
                                                                .read<Wish>()
                                                                .getWishItems
                                                                .firstWhereOrNull(
                                                                    (element) =>
                                                                        element
                                                                            .documentId ==
                                                                        service
                                                                            .documentId) !=
                                                            null
                                                        ? context
                                                            .read<Book>()
                                                            .removeItem(service)
                                                        : await context
                                                            .read<Wish>()
                                                            .addWishItem(
                                                              service.name,
                                                              service.price,
                                                              service.imagesUrl,
                                                              service
                                                                  .documentId,
                                                              service.serId,
                                                            );
                                                    await Future.delayed(
                                                            const Duration(
                                                                microseconds:
                                                                    100))
                                                        .whenComplete(() {
                                                      context
                                                          .read<Book>()
                                                          .removeItem(service);
                                                      Navigator.pop(context);
                                                    });
                                                  },
                                                  child: const Text(
                                                      'Move to My Choices'),
                                                ),
                                                CupertinoActionSheetAction(
                                                  onPressed: () {
                                                    context
                                                        .read<Book>()
                                                        .removeItem(service);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                      'Delete service'),
                                                ),
                                                CupertinoActionSheetAction(
                                                  isDestructiveAction: true,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Cancel!'),
                                                ),
                                              ],
                                            ));
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    size: 18,
                                  )),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
