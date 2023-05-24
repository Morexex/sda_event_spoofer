import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:uuid/uuid.dart';

import '../widgets/appbar_widgets.dart';
import '../widgets/repeated_button_widget.dart';
import '../widgets/snackbar.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late String firstName;
  late String lastName;
  late String phone;
  String countryValue = 'Choose Country';
  String stateValue = 'Choose City';
  String cityValue = 'Choose Town';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ScaffoldMessenger(
        key: _scafoldKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: const AppBarBackButton(),
            title: const AppBarTitle(title: 'Add Address'),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 40, 30, 40),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your First Name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            firstName = value!;
                          },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'First Name',
                            hintText: 'Enter First Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Last Name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            lastName = value!;
                          },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Last Name',
                            hintText: 'Enter Last Name',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone Number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            phone = value!;
                          },
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Phone',
                            hintText: 'Enter Phone Number',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SelectState(
                    // style: TextStyle(color: Colors.red),
                    onCountryChanged: (value) {
                  setState(() {
                    countryValue = value;
                  });
                }, onStateChanged: (value) {
                  setState(() {
                    stateValue = value;
                  });
                }, onCityChanged: (value) {
                  setState(() {
                    cityValue = value;
                  });
                }),
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: RepeatedButton(
                      label: 'Add New Address', onPressed: () {}, width: 0.8),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: 'price',
  hintText: 'price..ksh',
  labelStyle: const TextStyle(color: Colors.black),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.purple, width: 1),
      borderRadius: BorderRadius.circular(25)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
      borderRadius: BorderRadius.circular(25)),
);

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}
