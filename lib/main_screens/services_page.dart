import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/main_screens/stores_screen.dart';
import 'package:sda_event_spoofer/minor_screens/search_screen.dart';

import '../gallery/audio_recording.dart';
import '../gallery/catering_gallery.dart';
import '../gallery/decoration_gallery.dart';
import '../gallery/graphics_gallery.dart';
import '../gallery/other_gallery.dart';
import '../gallery/photography.dart';
import '../gallery/sound_system_gallery.dart';
import '../gallery/tents_chairs_gallery.dart';
import '../gallery/transport_gallery.dart';
import '../gallery/video_recording.dart';

class ServicesPageScreen extends StatefulWidget {
  const ServicesPageScreen({super.key});

  @override
  State<ServicesPageScreen> createState() => _ServicesPageScreenState();
}

class _ServicesPageScreenState extends State<ServicesPageScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchScreen()));
            },
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber, width: 1.4),
                  borderRadius: BorderRadius.circular(25)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  const Text(
                    'What are you looking for',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Container(
                    height: 32,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'Search',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.amber,
              indicatorWeight: 6,
              tabs: [
                RepeatedTab(label: 'Graphics'),
                RepeatedTab(label: 'Audio Recording'),
                RepeatedTab(label: 'Photography'),
                RepeatedTab(label: 'Video Recording'),
                RepeatedTab(label: 'Transport'),
                RepeatedTab(label: 'Catering'),
                RepeatedTab(label: 'Decoration'),
                RepeatedTab(label: 'Tent & Chairs Rent'),
                RepeatedTab(label: 'Sound System Hiring'),
                RepeatedTab(label: 'Others'),
              ]),
        ),
        body: const TabBarView(children: [
          GraphicsGalleryScreen(),
          AudioRecordingScreen(),
          PhotographyScreen(),
          VideoRecordingScreen(),
          TransportScreen(),
          CateringScreen(),
          DecorationScreen(),
          TentsChairsScreen(),
          SoundSystemScreen(),
          OthersScreen(),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const StoresScreen()));
          },
          backgroundColor: Colors.amber,
          hoverColor: Colors.tealAccent,
          child: const Icon(
            Icons.store,
            color: Colors.teal,
            size: 35,
          ),
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
