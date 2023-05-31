// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import '../widgets/appbar_widgets.dart';
import '../widgets/repeated_button_widget.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  bool checkOldPasswordValidation = true;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scafoldKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(),
          title: const AppBarTitle(title: 'Change Password'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 30),
            child: Form(
              key: formKey,
              child: Column(children: [
                const Center(
                  child: Text(
                    'to change password, please fill in the form below and click save chnages',
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.1,
                      color: Colors.blueGrey,
                      fontFamily: 'Acme',
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your password';
                      }
                      return null;
                    },
                    controller: oldPasswordController,
                    decoration: passwordFormDecoration.copyWith(
                      labelText: 'Old Password',
                      hintText: 'Enter Your Current Password',
                      errorText: checkOldPasswordValidation != true ? 'not valid' : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your new password';
                      }
                      return null;
                    },
                    controller: newPasswordController,
                    decoration: passwordFormDecoration.copyWith(
                      labelText: 'New Password',
                      hintText: 'Enter Your New Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    validator: (value) {
                      if (value != newPasswordController.text) {
                        return 'password not matching';
                      } else if (value!.isEmpty) {
                        return 'Confirm new Password!';
                      }
                      return null;
                    },
                    decoration: passwordFormDecoration.copyWith(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Your New Password',
                    ),
                  ),
                ),
                FlutterPwValidator(
                  controller: newPasswordController,
                  minLength: 8,
                  uppercaseCharCount: 1,
                  numericCharCount: 2,
                  specialCharCount: 1,
                  normalCharCount: 3,
                  width: 400,
                  height: 150,
                  onSuccess: () {},
                  onFail: () {},
                ),
                const Spacer(),
                RepeatedButton(
                  label: 'Save Changes',
                  onPressed: () async {/* 
                    if (formKey.currentState!.validate()) {
                      checkOldPasswordValidation = await AuthRepo.checkOldPassword(
                          FirebaseAuth.instance.currentUser!.email!,
                          oldPasswordController.text);
                      setState(() {});
                      checkOldPasswordValidation == true
                          ? await AuthRepo.updateUserPassword(
                                  newPasswordController.text.trim())
                              .whenComplete(() {
                              formKey.currentState!.reset();
                              newPasswordController.clear();
                              oldPasswordController.clear();
                              MyMessageHandler.showSnackbar(_scafoldKey,
                                  'your password has been Updated!');
                              Future.delayed(const Duration(seconds: 3))
                                  .whenComplete(() => Navigator.pop(context));
                            })
                          : print('invalid old password');
                      print('form valid');
                    } else {
                      print('not valid');
                    } */
                  },
                  width: 0.7,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

var passwordFormDecoration = InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter your full name',
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.teal, width: 1),
      borderRadius: BorderRadius.circular(25)),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
  ),
);