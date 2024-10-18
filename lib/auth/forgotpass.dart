import 'package:acrehub/auth/auth_sevice.dart';
import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class forgotpassd extends StatefulWidget {
  const forgotpassd({super.key});

  @override
  State<forgotpassd> createState() => _forgotpassdState();
}

class _forgotpassdState extends State<forgotpassd> {
  TextEditingController femail = TextEditingController();
  final _auth = AuthSevice();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Lrbgclr(),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(left: 7.w, right: 7.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Center(
                    child: SizedBox(
                      height: 30.h,
                      width: 70.w,
                      child: Image.asset(
                        "assets/images/fpassd.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // SizedBox(height: 5.h),
                  Text(
                    "Enter E-mail to recieve reset Link",
                    style: GoogleFonts.amiriQuran(
                      fontSize: 18.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  TextFormField(
                    controller: femail,
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    style: GoogleFonts.alatsi(color: Colors.white),
                    cursorColor: Colors.white,
                    cursorWidth: 2.sp,
                    decoration: InputDecoration(
                        labelText: "E-mail",
                        labelStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.sp)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.sp)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.sp),
                        )),
                  ),
                  SizedBox(height: 5.h),
                  GestureDetector(
                    onTap: () async {
                      await _auth.sendPasswordResetLink(femail.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "An E-mail for password reset has been  sent to your E-mail"),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 5.h,
                      width: 42.w,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 26, 166, 89),
                          borderRadius: BorderRadius.circular(5.sp)),
                      child: Center(
                        child: Text(
                          "Send Link",
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
        )
      ],
    );
  }
}
