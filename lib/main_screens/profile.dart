// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/main_screens/bookings_page.dart';
import 'package:sda_event_spoofer/main_screens/general_screens/general_orders.dart';
import 'package:sda_event_spoofer/main_screens/general_screens/my_choice.dart';
import 'package:sda_event_spoofer/widgets/appbar_widgets.dart';

import '../widgets/profile_header.dart';
import '../widgets/repeated_list.dart.dart';
import '../widgets/teal_divider.dart';

class ProfileScreen extends StatefulWidget {
  /* final String documentId; */
  const ProfileScreen({super.key /* , required this.documentId */});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return //Text("Full Name: ${data['full_name']} ${data['full_name']}");

        Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: 240,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber, Colors.black45],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.white,
                expandedHeight: 150,
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: constraints.biggest.height <= 120 ? 1 : 0,
                      child: const Text(
                        'Account',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber, Colors.black54],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 30),
                        child: Row(
                          children: const [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('images/inapp/guest.jpg'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                'Moses Nyanaro',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30))),
                            child: TextButton(
                              child: SizedBox(
                                height: 37,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Bookings',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 16),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BookingScreen(back: AppBarBackButton(),)));
                              },
                            ),
                          ),
                          Container(
                            color: Colors.amber,
                            child: TextButton(
                              child: SizedBox(
                                height: 37,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'Tickets',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GeneralTicketsScreen()));
                              },
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30))),
                            child: TextButton(
                              child: SizedBox(
                                height: 37,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: const Center(
                                  child: Text(
                                    'My Choice',
                                    style: TextStyle(
                                        color: Colors.amber, fontSize: 16),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyChoiceScreen()));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 180,
                            child: Image(
                                image:
                                    AssetImage('images/inapp/Techspace 1.png')),
                          ),
                          const ProfileHeaderLabel(
                            headerLabel: '  Account Info  ',
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  const RepeatedListTile(
                                    title: 'Email Address',
                                    subTitle: 'ynanaromorexex@gmail.com',
                                    icon: Icons.email,
                                  ),
                                  const PurpleDivider(),
                                  const RepeatedListTile(
                                    title: 'Phone Number',
                                    subTitle: '0718702921',
                                    icon: Icons.phone,
                                  ),
                                  const PurpleDivider(),
                                  RepeatedListTile(
                                    onPressed: () {},
                                    title: 'Address',
                                    subTitle: '',
                                    /* data['address']==''? 'example@kangaru-Embu': data['address'] */
                                    icon: Icons.location_pin,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const ProfileHeaderLabel(
                              headerLabel: ' Account Setting '),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 260,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  RepeatedListTile(
                                    title: 'Edit Profile',
                                    subTitle: '',
                                    icon: Icons.edit,
                                    onPressed: () {},
                                  ),
                                  const PurpleDivider(),
                                  RepeatedListTile(
                                    title: 'Change Password',
                                    icon: Icons.lock,
                                    onPressed: () {},
                                  ),
                                  const PurpleDivider(),
                                  RepeatedListTile(
                                    title: 'Log Out',
                                    icon: Icons.logout,
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(context, '/welcome_screen');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
