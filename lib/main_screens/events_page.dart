import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/main_screens/post_event.dart';
import '../minor_screens/search_screen.dart';
import '../widgets/big_text.dart';
import '../widgets/smal_text.dart';

class EventsPageScreen extends StatefulWidget {
  const EventsPageScreen({super.key});

  @override
  State<EventsPageScreen> createState() => _EventsPageScreenState();
}

class _EventsPageScreenState extends State<EventsPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchScreen()));
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
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.teal)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                          image: AssetImage("images/event/event 4.jpg"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            BigText(
                                color: Colors.teal,
                                text:
                                    'Launching Event Coming Soon in The Casseral castle'),
                            SmallText(
                              text:
                                  'Welcome to the university of embu launch that will take place in Kaptembwo Angaza Grounds hosted by Angaza kaptembwo youths indefinately.Welcome to the university of embu launch that will take place in Kaptembwo Angaza Grounds hosted by Angaza kaptembwo youths indefinately',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.message,
                                size: 15,
                                color: Colors.teal,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SmallText(text: '1243'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 15,
                                color: Colors.teal,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SmallText(text: 'Location'),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                size: 15,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SmallText(text: '1243'),
                              const SizedBox(
                                width: 5,
                              ),
                              SmallText(text: 'Likes'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const PostEvent()));
        },
        backgroundColor: Colors.amber,
        hoverColor: Colors.tealAccent,
        child: const Icon(Icons.post_add,color: Colors.teal,size: 35,),
        ),
    );
  }
}
