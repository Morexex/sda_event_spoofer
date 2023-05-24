import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/auth/supplier_login.dart';
import 'package:sda_event_spoofer/widgets/big_text.dart';

import '../auth/general_login.dart';


const textColor = [
  Colors.amber,
  Colors.teal,
  Colors.blueAccent,
  Colors.purpleAccent,
  Colors.red,
  Colors.lime
];
const textStyle =
    TextStyle(fontSize: 45, fontWeight: FontWeight.bold, fontFamily: 'Acme');

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const  BoxDecoration(image: DecorationImage(image: AssetImage("images/inapp/cover2.jpg"),fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'WELCOME TO',
                    textStyle: textStyle,
                    colors: textColor,
                  ),
                  ColorizeAnimatedText(
                    'EVENT SPOOFER',
                    textStyle: textStyle,
                    colors: textColor,
                  )
                ],
                isRepeatingAnimation: true,
                repeatForever: true,
              ),

            const SizedBox(
              height: 120,
            ),
            Center(
              child: Card(
                color: Colors.grey.shade200.withOpacity(0.6),
                shadowColor: Colors.amber,
                child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BigText(color: Colors.black, text: 'Event Spoofer'),
                        Material(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * 0.6,
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/generalLogin_screen');
                            },
                            child: const Text(
                              'Get Started',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * 0.6,
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/supplierLogin_screen');
                            },
                            child: const Text(
                              'Services Providers Only',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
