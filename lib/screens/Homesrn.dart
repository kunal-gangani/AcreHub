// ignore_for_file: file_names, camel_case_types

import 'package:acrehub/screens/listcasting.dart';
import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Homeesrn extends StatefulWidget {
  const Homeesrn({super.key});

  @override
  State<Homeesrn> createState() => _HomeesrnState();
}

class _HomeesrnState extends State<Homeesrn> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Bgclr(),
        const Lrbgclr(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w),
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Row(
                    children: [
                      SizedBox(width: 5.w),
                      Image.asset(
                        "assets/images/Logo.png",
                        height: 50.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: Text(
                          "AcreHub",
                          style: GoogleFonts.aoboshiOne(
                            fontSize: 38.sp,
                            color: const Color.fromARGB(255, 26, 166, 89),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                    ],
                  ),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('properties')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Something went wrong',
                              style: GoogleFonts.poppins(
                                fontSize: 23.sp,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              'No Properties Found',
                              style: GoogleFonts.poppins(
                                fontSize: 23.sp,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        final properties = snapshot.data!.docs;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: properties.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var property = properties[index].data()
                                  as Map<String, dynamic>;
                              List<dynamic>? amenities = property['amenities'];
                              String amenitiesPreview = amenities != null
                                  ? amenities.join(', ')
                                  : 'No Amenities';
                              // Handle a list of image URLs
                              List<dynamic>? imageUrls = property['images'];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.h),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => listcastingsrn(
                                          property: property,
                                          id: properties[index].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    shadowColor: Colors.black,
                                    elevation: 8,
                                    child: Container(
                                      height: 32.h,
                                      width: 35.w,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius:
                                            BorderRadius.circular(1.h),
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1.h),
                                            child: Container(
                                              height: 25.h,
                                              width: 43.h,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(1.h),
                                              ),
                                              child: imageUrls != null &&
                                                      imageUrls.isNotEmpty
                                                  ? Image.network(
                                                      imageUrls.first,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : const Icon(Icons
                                                      .image_not_supported),
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 60.w),
                                            child: Text(
                                              property['landType'] ??
                                                  'No Title',
                                              style: GoogleFonts.kanit(
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 1.w),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Text(
                                                  property['landAmount'] ??
                                                      'No Area',
                                                  style: GoogleFonts.kanit(
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 5.w),
                                                child: Text(
                                                  property['areaName'] ??
                                                      'No Area',
                                                  style: GoogleFonts.kanit(
                                                    fontSize: 10.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      })
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}


//  TextFormField(
//                     controller: search,
//                     style: GoogleFonts.alatsi(color: Colors.grey),
//                     showCursor: false,
//                     decoration: InputDecoration(
//                         isDense: true,
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide.none,
//                           borderRadius: BorderRadius.circular(25.sp),
//                         ),
//                         prefixIcon: Icon(Icons.search, size: 4.h),
//                         prefixIconColor: Colors.grey,
//                         fillColor: Colors.white,
//                         filled: true,
//                         hintText: "Search",
//                         hintStyle: GoogleFonts.alatsi(
//                           letterSpacing: 1.sp,
//                           color: Colors.grey,
//                           fontSize: 15.sp,
//                         )),
//                   ),
