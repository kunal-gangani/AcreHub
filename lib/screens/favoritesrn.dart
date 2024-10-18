import 'package:acrehub/screens/listcasting.dart';
import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Favoritesrn extends StatefulWidget {
  const Favoritesrn({super.key});

  @override
  State<Favoritesrn> createState() => _FavoritesrnState();
}

class _FavoritesrnState extends State<Favoritesrn> {
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
                        "Favorites",
                        style: GoogleFonts.aoboshiOne(
                          fontSize: 30.sp,
                          color: const Color.fromARGB(255, 26, 166, 89),
                        ),
                      ),
                    ),
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('properties')
                        .where("is_favourite", isEqualTo: 1)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
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
                                onTap: () {
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
                                      borderRadius: BorderRadius.circular(1.h),
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
                                                : const Icon(
                                                    Icons.image_not_supported),
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Padding(
                                          padding: EdgeInsets.only(right: 60.w),
                                          child: Text(
                                            property['landType'] ?? 'No Title',
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
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
