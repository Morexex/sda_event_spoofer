// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utilities/cat_list.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scafoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String proName;
  late String proDesc;
  late String proId;
  int ? discount =0;
  String mainCategValue = 'select category';
  String subCategValue = 'subcategory';
  List<String> subCategoryList = [];
  
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
            return Image.file(File(imagesFileList![index].path));
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
    return ScaffoldMessenger(
      key: _scafoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      color: Colors.blueGrey.shade100,
                      height: size.width * 0.5,
                      width: size.width * 0.5,
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
                    SizedBox(
                      height: size.width * 0.5,
                      width: size.width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Select Main Category',
                                style: TextStyle(color: Colors.red),
                              ),
                              DropdownButton(
                                  iconSize: 40,
                                  iconEnabledColor: Colors.red,
                                  dropdownColor: Colors.yellow.shade400,
                                  value: mainCategValue,
                                  items: maincateg
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                  }),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Select Sub-Category',
                                  style: TextStyle(color: Colors.red)),
                              DropdownButton(
                                  iconSize: 40,
                                  iconEnabledColor: Colors.red,
                                  dropdownColor: Colors.yellow.shade400,
                                  menuMaxHeight: 500,
                                  disabledHint: const Text('select category'),
                                  value: subCategValue,
                                  items: subCategoryList
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    print(value);
                                    setState(() {
                                      subCategValue = value!;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.purple,
                      thickness: 2,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter price';
                                } else if (value.isValidPrice() != true) {
                                  return 'invalid Price';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                price = double.parse(value!);
                              },
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: textFormDecoration.copyWith(
                                labelText: 'Price',
                                hintText: 'price..ksh',
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: TextFormField(
                            maxLength: 2,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return null;
                                }  else if (value.isValidDiscount() != true) {
                                  return 'invalid Price';
                                } 
                                return null;
                              },
                              onSaved: (value) {
                                discount = int.parse(value!);
                              },
                              keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true),
                              decoration: textFormDecoration.copyWith(
                                labelText: 'Discount',
                                hintText: 'discount..%',
                              )),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter Quantity';
                            } else if (value.isValidQuantity() != true) {
                              return 'not valid quantity';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            quantity = int.parse(value!);
                          },
                          keyboardType: TextInputType.number,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Quantity',
                            hintText: 'Add quatity',
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
                              return 'please enter product name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            proName = value!;
                          },
                          maxLength: 100,
                          maxLines: 3,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Product Name',
                            hintText: 'Enter Product Name',
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
                              return 'please enter product description';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            proDesc = value!;
                          },
                          maxLength: 800,
                          maxLines: 5,
                          decoration: textFormDecoration.copyWith(
                            labelText: 'Product Descriprion',
                            hintText: 'Enter Product Description',
                          )),
                    ),
                  ),
                ],
              ),
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
                backgroundColor: Colors.purple,
                child: imagesFileList!.isEmpty
                    ? const Icon(Icons.photo_library)
                    : const Icon(Icons.delete_forever),
              ),
            ),
            FloatingActionButton(
              onPressed: processing == true
                  ? null
                  : () {
                    },
              backgroundColor: Colors.purple,
              child: processing == true
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.upload),
            )
          ],
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

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}

extension DiscountValidator on String {
  bool isValidDiscount() {
    return RegExp(r'^([0-99]*)$')
        .hasMatch(this);
  }
}