import 'dart:async';

import 'package:acrehub/screens/Homesrn.dart';
import 'package:acrehub/screens/bottombar.dart';
import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class listcastingsrn extends StatefulWidget {
  final Map<String, dynamic> property;
  final String id;
  const listcastingsrn({super.key, required this.property, required this.id});

  @override
  State<listcastingsrn> createState() => _listcastingsrnState();
}

class _listcastingsrnState extends State<listcastingsrn> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<dynamic>? amenities = widget.property['amenities'];
    String amenitiesList =
        amenities != null ? amenities.join(', ') : 'No Amenities';
    List<dynamic>? imageUrls = widget.property['images'];
    return Stack(
      children: [
        Lrbgclr(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            toolbarHeight: 5.h,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    print("123");
                    int fav = widget.property['is_favourite'];
                    if (fav == 1) {
                      fav = 0;
                    } else {
                      fav = 1;
                    }
                    widget.property['is_favourite'] = fav;
                    updateDocument(fav);
                    setState(() {});
                  },
                  icon: (widget.property['is_favourite'] ?? 0) == 1
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_outline,
                        ),
                ),
              ),
              SizedBox(width: 5.w),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(right: 3.w, left: 3.w),
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  CarouselSlider(
                    items: imageUrls
                        ?.map((imageUrl) => ClipRRect(
                              borderRadius: BorderRadius.circular(3.sp),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      pauseAutoPlayInFiniteScroll: false,
                      enableInfiniteScroll: false,
                      height: 30.h,
                      viewportFraction: 1.0, // Show one image at a time
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Selling Amount :  ${widget.property['landAmount'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 22.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Land Type : ${widget.property['landType'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Land Area : ${widget.property['landArea'] ?? 'Not Available'} acres',
                      style: GoogleFonts.kanit(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Area Name : ${widget.property['areaName'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'City : ${widget.property['city'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'OpenSides : ${widget.property['openSides'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Token Amount : ${widget.property['tokenAmount'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 17.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Ownership : ${widget.property['ownerShip'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Amenities : $amenitiesList',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Owners Name : ${widget.property['ownerName'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Owners Number : ${widget.property['contactNo'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Owners E-mail : ${widget.property['ownerE-mail'] ?? 'Not Available'}',
                      style: GoogleFonts.kanit(
                        fontSize: 20.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> updateDocument(fav) async {
    try {
      await FirebaseFirestore.instance
          .collection('properties')
          .doc(widget.id)
          .update({"is_favourite": fav});
      print('Document updated successfully');
    } catch (e) {
      print('Error updating document: $e');
    }
    setState(() {});
  }
}
