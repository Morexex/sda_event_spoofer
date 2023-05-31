import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../minor_screens/edit_service.dart';
import '../minor_screens/services_details.dart';
import '../providers/mychoice_provider.dart';
import '../widgets/smal_text.dart';

class ServicesModel extends StatelessWidget {
  final dynamic services;
  const ServicesModel({
    super.key,
    this.services,
  });

  @override
  Widget build(BuildContext context) {
    var onSale = services['discount'];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiceDetailsScreen(
                      serList: services,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Container(
                      constraints:
                          const BoxConstraints(minHeight: 100, maxHeight: 250),
                      child:
                          Image(image: NetworkImage(services['proimages'][0])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                            color: Colors.black, text: services['sername']),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Ksh',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(services['price'].toStringAsFixed(2),
                                    style: onSale != 0
                                        ? const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w600)
                                        : const TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          )),
                                const SizedBox(
                                  width: 6,
                                ),
                                onSale != 0
                                    ? Text(
                                        ((1 - (services['discount'] / 100)) *
                                                services['price'])
                                            .toStringAsFixed(2),
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : const Text(''),
                              ],
                            ),
                            services['sid'] ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                EditService(items: services,)));
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Colors.red))
                                : IconButton(
                                    onPressed: () {
                                      var existingItemWishlist = context
                                          .read<Wish>()
                                          .getWishItems
                                          .firstWhereOrNull((service) =>
                                              service.documentId ==
                                              services['serid']);
                                      existingItemWishlist != null
                                          ? context
                                              .read<Wish>()
                                              .removeThis(services['serid'])
                                          : context.read<Wish>().addWishItem(
                                                services['sername'],
                                                onSale != 0
                                                    ? ((1 -
                                                            (services[
                                                                    'discount'] /
                                                                100)) *
                                                        services['price'])
                                                    : services['price'],
                                                services['proimages'],
                                                services['serid'],
                                                services['sid'],
                                              );
                                    },
                                    icon: context
                                                .watch<Wish>()
                                                .getWishItems
                                                .firstWhereOrNull((service) =>
                                                    service.documentId ==
                                                    services['serid']) !=
                                            null
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 30,
                                          )
                                        : const Icon(
                                            Icons.favorite_outline,
                                            color: Colors.red,
                                            size: 30,
                                          )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onSale != 0
                ? Positioned(
                    top: 30,
                    left: 0,
                    child: Container(
                      height: 25,
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                      child: Center(
                        child: Text(
                          'save ${onSale.toString()} %',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                  ),
          ],
        ),
      ),
    );
  }
}
