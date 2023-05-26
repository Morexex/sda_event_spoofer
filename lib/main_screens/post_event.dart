// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';
import '../../minor_screens/add_address.dart';
import 'package:path/path.dart' as path;

import '../../widgets/snackbar.dart';
import '../widgets/appbar_widgets.dart';

class PostEvent extends StatefulWidget {
  const PostEvent({super.key});

  @override
  State<PostEvent> createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scafoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String eveName;
  late String eveDesc;
  late String eveId;

  bool processing = false;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagesFileList = [];
  List<String> imagesUrlList = [];
  dynamic _pickedImageError;

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imagesFileList = pickedImages;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (imagesFileList!.isNotEmpty) {
      return ListView.builder(
          itemCount: imagesFileList!.length,
          itemBuilder: (context, index) {
            return Image.file(
                File(
                  imagesFileList![index].path,
                ),
                fit: BoxFit.cover);
          });
    } else {
      return const Center(
        child: Text(
          'You have not \n \n picked Image yet!',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
  }
  Future<void> uploadImages() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        if (imagesFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref('events/${path.basename(image.path)}');
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imagesUrlList.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
        } else {
          MyMessageHandler.showSnackbar(
              scafoldKey, 'please pick images first');
        }
      } else {
        MyMessageHandler.showSnackbar(scafoldKey, 'please fill all fields');
      }
    
  }


Future<void> uploadData() async {
    if (imagesUrlList.isNotEmpty) {
      CollectionReference eventsRef =
          FirebaseFirestore.instance.collection('events');

      eveId = const Uuid().v4();

      await eventsRef.doc(eveId).set({
        'eveid': eveId,
        'evename': eveName,
        'evedesc': eveDesc,
        'sid': FirebaseAuth.instance.currentUser!.uid,
        'gid': FirebaseAuth.instance.currentUser!.uid,
        'proimages': imagesUrlList,
      }).whenComplete(() {
        setState(() {
          processing = false;
          imagesFileList = [];
          imagesUrlList = [];
        });
        _formKey.currentState!.reset();
      });
    } else {
      print('no images');
    }
  }

  void uploadEvent() async {
    await uploadImages().whenComplete(() => uploadData());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(
          title: 'Post Event',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //color: Colors.blueGrey.shade100,
                height: size.width * 0.5,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.amberAccent.withOpacity(0.6)),
                child: imagesFileList != null
                    ? previewImages()
                    : const Center(
                        child: Text(
                          'You have not \n \n picked Image yet!',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
              const SizedBox(
                height: 30,
                child: Divider(
                  color: Colors.teal,
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter Event name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        eveName = value!;
                      },
                      maxLength: 100,
                      maxLines: 3,
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Event Name',
                        hintText: 'Enter Event Name',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter event description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        eveDesc = value!;
                      },
                      maxLength: 800,
                      maxLines: 5,
                      decoration: textFormDecoration.copyWith(
                        labelText: 'Event Descriprion',
                        hintText: 'Enter Event Description',
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              onPressed: imagesFileList!.isEmpty
                  ? () {
                      pickProductImages();
                    }
                  : () {
                      setState(() {
                        imagesFileList = [];
                      });
                    },
              backgroundColor: Colors.teal,
              child: imagesFileList!.isEmpty
                  ? const Icon(Icons.photo_library)
                  : const Icon(Icons.delete_forever),
            ),
          ),
          FloatingActionButton(
            onPressed: processing == true ? null : () {
              uploadEvent();
            },
            backgroundColor: Colors.teal,
            child: processing == true
                ? const CircularProgressIndicator(color: Colors.amber,)
                : const Icon(Icons.upload),
          )
        ],
      ),
    );
  }
}
