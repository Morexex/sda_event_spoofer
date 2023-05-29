import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

import '../providers/bookings_provider.dart';
import '../providers/mychoice_provider.dart';
import '../providers/service_provider.dart';

class MyChoiceModel extends StatelessWidget {
  const MyChoiceModel({
    super.key,
    required this.service,
  });

  final Service service;

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
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<Wish>().removeWishItem(service);
                                },
                                icon: const Icon(Icons.delete_forever)),
                            const SizedBox(
                              width: 10,
                            ),
                            context.watch<Book>().getItems.firstWhereOrNull(
                                        (element) =>
                                            element.documentId ==
                                            service.documentId) !=
                                    null
                                ? const SizedBox()
                                : IconButton(
                                    onPressed: () {
                                      context.read<Book>().addItem(
                                            service.name,
                                            service.price,
                                            service.imagesUrl,
                                            service.documentId,
                                            service.serId,
                                          );
                                    },
                                    icon: const Icon(Icons.add_shopping_cart))
                          ],
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
