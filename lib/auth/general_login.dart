// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/widgets/authentication_widgets.dart';
import 'package:sda_event_spoofer/widgets/repeated_button_widget.dart';

class GeneralLoginScreen extends StatefulWidget {
  const GeneralLoginScreen({super.key});

  @override
  State<GeneralLoginScreen> createState() => _GeneralLoginScreenState();
}

class _GeneralLoginScreenState extends State<GeneralLoginScreen> {
  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool passwordVisible = true;
  bool processing = false;
  bool sendEmailVerification = false;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scafoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AuthHeaderLabel(
                        headerLabel: 'Log In',
                      ),
                      SizedBox(
                        height: 50,
                        child: sendEmailVerification == true
                            ? RepeatedButton(
                                label: 'Resend Email Verifification',
                                onPressed: () {},
                                width: 0.6)
                            : const SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            } else if (value.isValidAEmail() == false) {
                              return 'Invalid Email!';
                            } else if (value.isValidAEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          //controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Email Address',
                            hintText: 'example@gmail.com',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            password = value;
                          },
                          //controller: _passwordController,
                          obscureText: passwordVisible,
                          decoration: textFormDecoration.copyWith(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.teal,
                                )),
                            labelText: 'Password',
                            hintText: 'Enter your Password',
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'forgot password?',
                          style: TextStyle(
                              fontSize: 18, fontStyle: FontStyle.italic),
                        ),
                      ),
                      HaveAccount(
                        haveAccount: 'Dont have an account? ',
                        actionLabel: 'Sign Up',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/generalSignup_screen');
                        },
                      ),
                      processing == true
                          ? const CircularProgressIndicator(
                              color: Colors.teal,
                            )
                          : AuthMainButton(
                              mainButtonLabel: 'Log In',
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/general_home');
                              },
                            ),
                      divider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget divider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          width: 80,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Text(' or ', style: TextStyle(color: Colors.grey)),
        SizedBox(
          width: 80,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        )
      ],
    ),
  );
}
