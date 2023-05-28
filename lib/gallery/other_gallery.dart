import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/widgets/big_text.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../models/services_model.dart';

class OthersScreen extends StatefulWidget {
  const OthersScreen({super.key});

  @override
  State<OthersScreen> createState() => _OthersScreenState();
}

class _OthersScreenState extends State<OthersScreen> {
  final Stream<QuerySnapshot> _servicesStream = FirebaseFirestore.instance
      .collection('services')
      .where('subcateg', isEqualTo: 'other')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _servicesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
              child: BigText(
                  color: Colors.blueGrey,
                  text:
                      '        No services under \n this category posted yet'));
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
              staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
        );
      },
    );
  }
}
