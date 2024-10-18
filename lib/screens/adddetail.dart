import 'dart:io';

import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:acrehub/widgets/txtfld.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class Addpropertydtil extends StatefulWidget {
  const Addpropertydtil({super.key});

  @override
  State<Addpropertydtil> createState() => _AddpropertydtilState();
}

class _AddpropertydtilState extends State<Addpropertydtil> {
  // checkbox values
  final Map<String, bool> _amenities = {
    'Electricity': false,
    'Borewell': false,
    'Fencing': false,
    'Sheds': false,
    'WareHouse': false,
    'Rooms': false,
    'WashRooms': false,
  };

  // choice chip values
  String? landType = '';
  String? noOpensids = '';
  String? ownership = '';

  // txtfld values
  TextEditingController landarea = TextEditingController();
  TextEditingController areanme = TextEditingController();
  TextEditingController cty = TextEditingController();
  TextEditingController lamt = TextEditingController();
  TextEditingController tamt = TextEditingController();
  TextEditingController onme = TextEditingController();
  TextEditingController cno = TextEditingController();
  TextEditingController oeml = TextEditingController();

  //image picker
  List<XFile?> imageFiles = [];
  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile?> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        imageFiles = images;
      });
    }
  }

// image baki
//send data to firebase
  Future<void> _submitData() async {
    try {
      Map<String, dynamic> propertyData = {
        'landType': landType,
        'landArea': landarea.text.toString(),
        'openSides': noOpensids,
        'areaName': areanme.text.toString(),
        'city': cty.text.toString(),
        'amenities': _amenities.keys
            .where(
              (amenity) => _amenities[amenity] == true,
            )
            .toList(),
        'landAmount': lamt.text.toString(),
        'tokenAmount': tamt.text.toString(),
        'ownerName': onme.text.toString(),
        'contactNo': cno.text.toString(),
        'ownerE-mail': oeml.text.toString(),
        'ownerShip': ownership
      };
      await FirebaseFirestore.instance
          .collection('properties')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(propertyData);

      final storage =
          FirebaseStorage.instanceFor(bucket: "gs://acrehub-1a3b4.appspot.com");

      if (imageFiles.isNotEmpty) {
        debugPrint("got to this");

        for (int i = 0; i < imageFiles.length; i++) {
          String filePath = imageFiles[i]!.path;
          File file = File(filePath);
          String fileName = 'properties/_image_$i';
          await storage
              .ref()
              .child("profile/$i.jpg")
              .putFile(file)
              .then((TaskSnapshot taskSnapshot) {
            if (taskSnapshot.state == TaskState.success) {
              taskSnapshot.ref.getDownloadURL().then((imageURL) async {
                /// So it is better that when you add new document, give any static document id like userId
                /// exa:-  await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).set({ <Your map data> });

                await FirebaseFirestore.instance
                    .collection('properties')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  'images': FieldValue.arrayUnion([imageURL])
                });
              });
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Not Uploaded')));
            }
          });
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Property details submitted successfully!')));
    } catch (e) {
      print('Error adding property: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit Property details!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Lrbgclr(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: 10.h,
                  width: double.infinity,
                  decoration:
                      const BoxDecoration(color: Color(0xFFD9EAFB), boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(158, 0, 0, 0),
                      blurRadius: 7.0,
                    )
                  ]),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 3.h),
                      child: Text(
                        "Add Property Detail",
                        style: GoogleFonts.aoboshiOne(
                          fontSize: 24.sp,
                          color: const Color.fromARGB(255, 26, 166, 89),
                          // color: Colors.brown,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Padding(
                    padding: EdgeInsets.only(right: 30.h),
                    child: Text(
                      "Land Type",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 3.h),
                      ChoiceChip(
                        label: const Text('Agriculture'),
                        labelStyle: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        selected: landType == 'Agriculture',
                        onSelected: (selected) {
                          setState(() {
                            landType = 'Agriculture';
                          });
                        },
                        selectedColor: Colors.green,
                        backgroundColor: const Color(0xFFD9EAFB),
                      ),
                      SizedBox(width: 1.h),
                      ChoiceChip(
                        label: const Text('Industrial'),
                        labelStyle: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        selected: landType == 'Industrial',
                        onSelected: (selected) {
                          setState(() {
                            landType = 'Industrial';
                          });
                        },
                        selectedColor: Colors.green,
                        backgroundColor: const Color(0xFFD9EAFB),
                      ),
                      SizedBox(width: 1.h),
                      ChoiceChip(
                        label: const Text("Commercial"),
                        labelStyle: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        selected: landType == 'Commercial',
                        onSelected: (selected) {
                          setState(() {
                            landType = 'Commercial';
                          });
                        },
                        backgroundColor: const Color(0xFFD9EAFB),
                        selectedColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 30.h),
                    child: Text(
                      "Land Area",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                TextFieldInput(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please enter the Number ';
                      }
                      return null;
                    },
                    textEditingController: landarea,
                    hintText: "Area ",
                    textInputType: TextInputType.number),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 16.h),
                    child: Text(
                      "Number of Open Sides",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 3.h),
                    ChoiceChip(
                      label: const Text('1'),
                      labelStyle: GoogleFonts.montserrat(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      selected: noOpensids == '1',
                      onSelected: (selected) {
                        setState(() {
                          noOpensids = '1';
                        });
                      },
                      selectedColor: Colors.green,
                      backgroundColor: const Color(0xFFD9EAFB),
                    ),
                    SizedBox(width: 1.h),
                    ChoiceChip(
                      label: const Text('2'),
                      labelStyle: GoogleFonts.montserrat(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      selected: noOpensids == '2',
                      onSelected: (selected) {
                        setState(() {
                          noOpensids = '2';
                        });
                      },
                      selectedColor: Colors.green,
                      backgroundColor: const Color(0xFFD9EAFB),
                    ),
                    SizedBox(width: 1.h),
                    ChoiceChip(
                      label: const Text("3+"),
                      labelStyle: GoogleFonts.montserrat(
                          color: Colors.black, fontWeight: FontWeight.w600),
                      selected: noOpensids == '3+',
                      onSelected: (selected) {
                        setState(() {
                          noOpensids = '3+';
                        });
                      },
                      backgroundColor: const Color(0xFFD9EAFB),
                      selectedColor: Colors.green,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 29.h),
                    child: Text(
                      "Area Name",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                TextFieldInput(
                  textEditingController: areanme,
                  hintText: "Area Name",
                  textInputType: TextInputType.streetAddress,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter the Area Name ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 37.h),
                    child: Text(
                      "City",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                TextFieldInput(
                  textEditingController: cty,
                  hintText: "City",
                  textInputType: TextInputType.streetAddress,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter the City ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 30.h),
                    child: Text(
                      "Amenities",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                Column(
                  children: _amenities.keys.map((String amenity) {
                    return CheckboxListTile(
                      value: _amenities[amenity],
                      onChanged: (bool? value) {
                        setState(() {
                          _amenities[amenity] = value ?? false;
                        });
                      },
                      side: const BorderSide(color: Colors.white),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: _getIconForAmenity(amenity),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 4.w),
                              child: Text(
                                amenity,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 25.h),
                    child: Text(
                      "Land Amount",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                TextFieldInput(
                  textEditingController: lamt,
                  hintText: "Selling Amount",
                  textInputType: TextInputType.number,
                  validator: (number) {
                    if (number == null || number.isEmpty) {
                      return 'Please enter the Land Amount ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 25.h),
                    child: Text(
                      "Token Amount",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                TextFieldInput(
                  textEditingController: tamt,
                  hintText: "Amount",
                  textInputType: TextInputType.number,
                  validator: (number) {
                    if (number == null || number.isEmpty) {
                      return 'Please enter the Token Amount ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                    padding: EdgeInsets.only(right: 25.h),
                    child: Text(
                      "Owner's Name",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                TextFieldInput(
                  textEditingController: onme,
                  hintText: "Name",
                  textInputType: TextInputType.name,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter the City ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 29.h),
                    child: Text(
                      "Contact No",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                TextFieldInput(
                  textEditingController: cno,
                  hintText: "Number",
                  textInputType: TextInputType.number,
                  validator: (number) {
                    if (number == null || number.isEmpty) {
                      return 'Please enter the Token Amount ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 23.h),
                    child: Text(
                      "E-mail of Owner",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                TextFieldInput(
                  textEditingController: oeml,
                  hintText: "E-mail",
                  textInputType: TextInputType.emailAddress,
                  validator: (text) {
                    if (!(text.contains('@')) && text.isNotEmpty) {
                      return "Enter a valid email address!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 29.h),
                    child: Text(
                      "Ownership",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 3.h),
                      ChoiceChip(
                        label: const Text('FreeHold'),
                        labelStyle: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        selected: ownership == 'FreeHold',
                        onSelected: (selected) {
                          setState(() {
                            ownership = 'FreeHold';
                          });
                        },
                        selectedColor: Colors.green,
                        backgroundColor: const Color(0xFFD9EAFB),
                      ),
                      SizedBox(width: 1.h),
                      ChoiceChip(
                        label: const Text('Power of Attorney'),
                        labelStyle: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        selected: ownership == 'Power of Attorney',
                        onSelected: (selected) {
                          setState(() {
                            ownership = 'Power of Attorney';
                          });
                        },
                        selectedColor: Colors.green,
                        backgroundColor: const Color(0xFFD9EAFB),
                      ),
                      SizedBox(width: 1.h),
                      ChoiceChip(
                        label: const Text("LeaseHold"),
                        labelStyle: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        selected: ownership == 'LeaseHold',
                        onSelected: (selected) {
                          setState(() {
                            ownership = 'LeaseHold';
                          });
                        },
                        backgroundColor: const Color(0xFFD9EAFB),
                        selectedColor: Colors.green,
                      ),
                      SizedBox(width: 1.h),
                      ChoiceChip(
                        label: const Text("Co-operative Society"),
                        labelStyle: GoogleFonts.montserrat(
                            color: Colors.black, fontWeight: FontWeight.w600),
                        selected: ownership == 'Co-operative Society',
                        onSelected: (selected) {
                          setState(() {
                            ownership = 'Co-operative Society';
                          });
                        },
                        backgroundColor: const Color(0xFFD9EAFB),
                        selectedColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                    padding: EdgeInsets.only(right: 29.h),
                    child: Text(
                      "Add Images",
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600),
                    )),
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    height: 25.h,
                    width: 88.w,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(55, 0, 0, 0),
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 8.h,
                            width: 18.w,
                            child: Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Colors.white,
                              size: 8.h,
                            ),
                          ),
                          Text(
                            "Click here to add Photos",
                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: _submitData,
                  child: Container(
                    height: 5.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 166, 89),
                        borderRadius: BorderRadius.circular(5.sp)),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: GoogleFonts.alatsi(
                            fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 11.h),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Icon _getIconForAmenity(String amenitys) {
  switch (amenitys) {
    case 'Electricity':
      return const Icon(
        Icons.electric_bolt_rounded,
        color: Colors.white,
      );
    case 'Borewell':
      return const Icon(
        Icons.abc,
        color: Colors.white,
      );
    case 'Fencing':
      return const Icon(
        Icons.fence_rounded,
        color: Colors.white,
      );
    case 'Sheds':
      return const Icon(
        Icons.wb_shade_sharp,
        color: Colors.white,
      );
    case 'WareHouse':
      return const Icon(
        Icons.warehouse_rounded,
        color: Colors.white,
      );
    case 'Rooms':
      return const Icon(
        Icons.house_rounded,
        color: Colors.white,
      );
    case 'WashRooms':
      return const Icon(
        Icons.family_restroom_rounded,
        color: Colors.white,
      );
    default:
      return const Icon(
        Icons.help,
        color: Colors.white,
      );
  }
}
