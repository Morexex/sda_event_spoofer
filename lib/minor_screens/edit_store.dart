// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../widgets/appbar_widgets.dart';
import '../widgets/repeated_button_widget.dart';
import '../widgets/snackbar.dart';

class EditStore extends StatefulWidget {
  final dynamic data;
  const EditStore({super.key, this.data});

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();
  XFile? imageFileLogo;
  XFile? imageFileCover;
  dynamic _pickedImageError;
  late String storeName;
  late String phoneNumber;
  late String storeLogo;
  late String storeCoverImage;
  bool processing = false;

  final ImagePicker _picker = ImagePicker();
  pickStoreLogo() async {
    try {
      final pickedStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileLogo = pickedStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  pickCoverImage() async {
    try {
      final pickedCoverImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileCover = pickedCoverImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Future uploadStoreLogo() async {
    if (imageFileLogo != null) {
      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref('store-logos/${widget.data['email']}.jpg');

        await ref.putFile(File(imageFileLogo!.path));

        storeLogo = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      storeLogo = widget.data['storelogo'];
    }
  }

  Future uploadCoverImage() async {
    if (imageFileCover != null) {
      try {
        firebase_storage.Reference ref2 = firebase_storage
            .FirebaseStorage.instance
            .ref('store-logos/${widget.data['email']}.jpg-cover');

        await ref2.putFile(File(imageFileCover!.path));

        storeCoverImage = await ref2.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      storeCoverImage = widget.data['coverpage'];
    }
  }

  editStoreData() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('suppliers')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        'name': storeName,
        'phone': phoneNumber,
        'storelogo': storeLogo,
        'coverpage': storeCoverImage
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  savedChanges() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() {
        processing = true;
      });
      await uploadStoreLogo().whenComplete(() async =>
          await uploadCoverImage().whenComplete(() => editStoreData()));
    } else {
      MyMessageHandler.showSnackbar(_scafoldKey, 'Fill all fields first!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scafoldKey,
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(title: 'Edit Store'),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                children: [
                  const Text(
                    'Store Logo',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(widget.data['storelogo']),
                        ),
                        Column(
                          children: [
                            RepeatedButton(
                                label: 'Change',
                                onPressed: () {
                                  pickStoreLogo();
                                },
                                width: 0.25),
                            const SizedBox(
                              height: 20,
                            ),
                            imageFileLogo == null
                                ? const SizedBox()
                                : RepeatedButton(
                                    label: 'Reset',
                                    onPressed: () {
                                      setState(() {
                                        imageFileLogo = null;
                                      });
                                    },
                                    width: 0.25),
                          ],
                        ),
                        imageFileLogo == null
                            ? const SizedBox()
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    FileImage(File(imageFileLogo!.path)),
                              ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Divider(
                      color: Colors.purple,
                      thickness: 2.5,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Cover Image',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(widget.data['coverpage']),
                        ),
                        Column(
                          children: [
                            RepeatedButton(
                                label: 'Change',
                                onPressed: () {
                                  pickCoverImage();
                                },
                                width: 0.25),
                            const SizedBox(
                              height: 20,
                            ),
                            imageFileCover == null
                                ? const SizedBox()
                                : RepeatedButton(
                                    label: 'Reset',
                                    onPressed: () {
                                      setState(() {
                                        imageFileCover = null;
                                      });
                                    },
                                    width: 0.25),
                          ],
                        ),
                        imageFileCover == null
                            ? const SizedBox()
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    FileImage(File(imageFileCover!.path)),
                              ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Divider(
                      color: Colors.purple,
                      thickness: 2.5,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Store Name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    storeName = value!;
                  },
                  initialValue: widget.data['name'],
                  decoration: textFormDecoration.copyWith(
                      labelText: 'store name', hintText: 'Enter Store Name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Phone Number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                  initialValue: widget.data['phone'],
                  decoration: textFormDecoration.copyWith(
                      labelText: 'phone', hintText: 'Enter Phone Number'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 40,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RepeatedButton(
                        label: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: 0.25),
                    const SizedBox(
                      width: 10,
                    ),
                    processing == true
                        ? RepeatedButton(
                            label: 'Please wait...',
                            onPressed: () {
                              null;
                            },
                            width: 0.5)
                        : RepeatedButton(
                            label: 'Save Changes',
                            onPressed: () {
                              savedChanges();
                            },
                            width: 0.5),
                  ],
                ),
              )
            ],
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
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.purple, width: 1),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
      borderRadius: BorderRadius.circular(10)),
);