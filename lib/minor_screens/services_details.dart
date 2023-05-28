import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:sda_event_spoofer/minor_screens/visit_store.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../main_screens/bookings_page.dart';
import '../models/services_model.dart';
import '../widgets/appbar_widgets.dart';
import '../widgets/repeated_button_widget.dart';
import 'full_screen_view.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final dynamic serList;

  const ServiceDetailsScreen({
    super.key,
    this.serList,
  });

  @override
  State<ServiceDetailsScreen> createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  late List<dynamic> imagesList = widget.serList['proimages'];

  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> servicesStream = FirebaseFirestore.instance
        .collection('services')
        .where('maincateg', isEqualTo: widget.serList['maincateg'])
        .where('subcateg', isEqualTo: widget.serList['subcateg'])
        .snapshots();
    return SafeArea(
      child: ScaffoldMessenger(
        key: _scafoldKey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FullScreenView(imagesList: imagesList)));
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Swiper(
                          pagination: const SwiperPagination(
                              builder: SwiperPagination.fraction),
                          itemBuilder: (context, index) {
                            return Image(
                              image: NetworkImage(
                                imagesList[index],
                              ),
                            );
                          },
                          itemCount: imagesList.length,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 20,
                        child: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                              )),
                        ),
                      ),
                      Positioned(
                          right: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share,
                                )),
                          ))
                    ],
                  ),
                ),
                Text(
                  widget.serList['sername'],
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Ksh ',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.serList['price'].toStringAsFixed(2),
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              '20',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.favorite_outline,
                          color: Colors.red,
                          size: 30,
                        )),
                  ],
                ),
                const ProductDetailsHeaderLabel(
                  label: '  Event Description  ',
                ),
                Text(
                  widget.serList['serdesc'],
                  textScaleFactor: 1.1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                Stack(
                  children: [
                    const Positioned(right: 50, top: 15, child: Text('Total')),
                    ExpandableTheme(
                      data: const ExpandableThemeData(
                        iconSize: 30,
                        iconColor: Colors.blue,
                      ),
                      child: const Text('Reviews under dev'),
                    ),
                  ],
                ),
                const ProductDetailsHeaderLabel(
                  label: '  Similar Events  ',
                ),
                SizedBox(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: servicesStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No items \n \n on this cateory yet!',
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

                      return SingleChildScrollView(
                        child: StaggeredGridView.countBuilder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          crossAxisCount: 2,
                          itemBuilder: (context, index) {
                            return ServicesModel(
                              services: snapshot.data!.docs[index],
                            );
                          },
                          staggeredTileBuilder: (context) =>
                              const StaggeredTile.fit(1),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VisitStore(sId: widget.serList['sid'])));
                        },
                        icon: const Icon(Icons.store)),
                    const SizedBox(
                      height: 20,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BookingScreen(
                                        back: AppBarBackButton(),
                                      )));
                        },
                        icon: const Icon(Icons.shopping_cart)),
                  ],
                ),
                RepeatedButton(
                    label: 'Add To Bookings', onPressed: () {}, width: 0.5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsHeaderLabel extends StatelessWidget {
  final String label;
  const ProductDetailsHeaderLabel({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.purple.shade900,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: TextStyle(
                color: Colors.purple.shade900,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.purple.shade900,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

Widget reviews(var reviewsStream) {
  return ExpandablePanel(
      header: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Reviews',
          style: TextStyle(
              color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      collapsed: SizedBox(
        height: 230,
        child: reviewsAll(reviewsStream),
      ),
      expanded: reviewsAll(reviewsStream));
}

Widget reviewsAll(var reviewsStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: reviewsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
      if (snapshot2.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot2.data!.docs.isEmpty) {
        return const Center(
          child: Text(
            'No Reviews\n \n on this product yet!',
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
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot2.data!.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshot2.data!.docs[index]['profileimage']),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(snapshot2.data!.docs[index]['name']),
                  Row(
                    children: [
                      Text(snapshot2.data!.docs[index]['rate'].toString()),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ],
                  ),
                ],
              ),
              subtitle: Text(snapshot2.data!.docs[index]['comment']),
            );
          });
    },
  );
}
