import 'dart:async';

import 'package:acrehub/auth/auth_sevice.dart';
import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:acrehub/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class emailverify extends StatefulWidget {
  const emailverify({super.key});

  @override
  State<emailverify> createState() => _emailverifyState();
}

class _emailverifyState extends State<emailverify> {
  final _auth = AuthSevice();
  late Timer timer;
  @override
  void initState() {
    super.initState();
    _auth.sendEmailVerificationLink();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        FirebaseAuth.instance.currentUser?.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
          timer.cancel();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Wrapper(),
              ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Lrbgclr(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(right: 3.w, left: 3.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "We have sent you an E-mail Verification Link in The E-mail.",
                    style: GoogleFonts.aoboshiOne(
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () async {
                    _auth.sendEmailVerificationLink();
                  },
                  child: Container(
                    height: 6.h,
                    width: 43.w,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 166, 89),
                        borderRadius: BorderRadius.circular(5.sp)),
                    child: Center(
                      child: Text(
                        "Resend E-mail",
                        style: GoogleFonts.alatsi(
                            fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
