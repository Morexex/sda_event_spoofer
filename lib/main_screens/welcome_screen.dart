import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/widgets/big_text.dart';

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
  bool processing = false;
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection("anonymous");
  late String _uid;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/inapp/cover2.jpg"), fit: BoxFit.cover)),
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
                              Navigator.pushReplacementNamed(
                                  context, '/generalLogin_screen');
                            },
                            child: const Text(
                              'Get Started',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(15),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width * 0.6,
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/supplierLogin_screen');
                            },
                            child: const Text(
                              'Services Providers Only',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            processing == true
                ? const CircularProgressIndicator()
                : CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 45,
                  child: SocialMediaButtons(
                      onPressed: () async {
                        await FirebaseAuth.instance
                            .signInAnonymously()
                            .whenComplete(() async {
                          _uid = FirebaseAuth.instance.currentUser!.uid;
                          await anonymous.doc(_uid).set({
                            'name': '',
                            'email': '',
                            'profileimage': '',
                            'phone': '',
                            'address': '',
                            'gid': _uid,
                          });
                        });
                
                        setState(() {
                          processing = true;
                        });
                        await Future.delayed(const Duration(microseconds: 100))
                            .whenComplete(() => Navigator.pushReplacementNamed(
                                context, '/general_home'));
                      },
                      label: 'Guest',
                      child: const Icon(
                        Icons.person,
                        size: 55,
                        color: Colors.amber,
                      ),
                    ),
                )
          ],
        ),
      ),
    );
  }
}

class SocialMediaButtons extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;
  const SocialMediaButtons({
    super.key,
    required this.label,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(height: 50, width: 50, child: child),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
