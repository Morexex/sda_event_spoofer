// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../minor_screens/add_address.dart';
import '../widgets/appbar_widgets.dart';

class PostEvent extends StatefulWidget {
  const PostEvent({super.key});

  @override
  State<PostEvent> createState() => _PostEventState();
}

class _PostEventState extends State<PostEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
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
                          return 'please enter product name';
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
            onPressed: processing == true ? null : () {},
            backgroundColor: Colors.teal,
            child: processing == true
                ? const CircularProgressIndicator()
                : const Icon(Icons.upload),
          )
        ],
      ),
    );
  }
}
