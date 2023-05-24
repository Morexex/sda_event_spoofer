import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/minor_screens/search_screen.dart';
import 'package:sda_event_spoofer/widgets/smal_text.dart';
import '../widgets/big_text.dart';

class MainEventPage extends StatefulWidget {
  const MainEventPage({super.key});

  @override
  State<MainEventPage> createState() => _MainEventPageState();
}

class _MainEventPageState extends State<MainEventPage> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var currPageValue = 0.0;
  double scaleFactor = 0.8;
  double height = 220;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            //color: Colors.amber,
            margin: const EdgeInsets.only(top: 45, bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(color: Colors.teal, text: 'Event Spoofer'),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()));
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.teal,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
              height: 35,
              child: BigText(color: Colors.black, text: 'Upcoming Events')),
          SizedBox(
            height: 320,
            child: PageView.builder(
                controller: pageController,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return buildPageItem(index);
                }),
          ),
          DotsIndicator(
            dotsCount: 5,
            position: currPageValue,
            decorator: const DotsDecorator(
              color: Colors.black87, // Inactive color
              activeColor: Colors.teal,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                BigText(color: Colors.black, text: 'Events Stream'),
                const SizedBox(
                  width: 10,
                ),
                SmallText(text: 'all events')
              ],
            ),
          ),
          SizedBox(
            height: 1000,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Container(
                          height: 150,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade200,
                            image: const DecorationImage(
                                image: AssetImage("images/event/event 2.jpg"),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SizedBox(
                            height: 140,
                            width: 225,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BigText(
                                  color: Colors.teal,
                                  text: 'University of Embu recording session',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                SmallText(
                                  text:
                                      'welcome to our promotion and music sabbath that will take place on ..because this is a testing session im just stating random giberish',
                                  maxLines: 4,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  Widget buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale =
          scaleFactor + (currPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - scaleFactor);

      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: 220,
            margin: const EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: index.isEven ? Colors.teal : Colors.blueGrey,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("images/event/event1.jpg"))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 130,
              width: 340,
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(color: Colors.black54, text: 'LivingStone Launch'),
                    const Text(
                      'We welcome you to our launch that will take place this sunday as from 8 am to noon please welcome to support us.',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'AkayaTelivigala',
                          color: Colors.teal),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      width: 10,
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
                            const SizedBox(
                              width: 5,
                            ),
                            SmallText(text: 'comments'),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
