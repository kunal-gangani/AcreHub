import 'package:acrehub/auth/auth_sevice.dart';
import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Profilesrn extends StatefulWidget {
  const Profilesrn({super.key});

  @override
  State<Profilesrn> createState() => _ProfilesrnState();
}

class _ProfilesrnState extends State<Profilesrn> {
  final _auth = AuthSevice();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Lrbgclr(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
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
                      "Profile",
                      style: GoogleFonts.aoboshiOne(
                        fontSize: 30.sp,
                        color: const Color.fromARGB(255, 26, 166, 89),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Container(
                height: 42.h,
                width: 96.w,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(55, 0, 0, 0),
                  borderRadius: BorderRadius.circular(1.h),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1.h, top: 2.h),
                      child: CircleAvatar(
                        radius: 75.sp,
                        backgroundColor: const Color.fromARGB(93, 0, 0, 0),
                        child: ClipOval(
                          child: Image.network(
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                              height: 150.sp,
                              "${FirebaseAuth.instance.currentUser?.photoURL}"),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        "${FirebaseAuth.instance.currentUser!.displayName}",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 25.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Text(
                        "${FirebaseAuth.instance.currentUser!.email}",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await _auth.signout(context);
                  },
                  child: Container(
                    height: 5.h,
                    width: 35.w,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 166, 89),
                        borderRadius: BorderRadius.circular(5.sp)),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: GoogleFonts.alatsi(
                            fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
