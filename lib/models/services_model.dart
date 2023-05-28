import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../minor_screens/services_details.dart';
import '../widgets/smal_text.dart';

class ServicesModel extends StatelessWidget {
  final dynamic services;
  const ServicesModel({
    super.key,
    this.services,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  ServiceDetailsScreen(serList: services,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
                  child: Image(image: NetworkImage(services['proimages'][0])),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(color: Colors.black, text: services['sername']),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(services['price'].toStringAsFixed(2) + (' Ksh')),
                       services['sid'] == FirebaseAuth.instance.currentUser!.uid?IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.red,
                            )): IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
