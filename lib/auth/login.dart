import 'package:acrehub/auth/auth_sevice.dart';
import 'package:acrehub/auth/forgotpass.dart';
import 'package:acrehub/screens/bottombar.dart';
import 'package:acrehub/auth/signup.dart';
import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Loginsrn extends StatefulWidget {
  const Loginsrn({super.key});

  @override
  State<Loginsrn> createState() => _LoginsrnState();
}

class _LoginsrnState extends State<Loginsrn> {
  final _auth = AuthSevice();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Lrbgclr(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.only(left: 7.w, right: 7.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Text(
                      "Welcome to",
                      style: GoogleFonts.aoboshiOne(
                          fontSize: 35.sp, color: Colors.grey[200]),
                    ),
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
                  SizedBox(height: 8.h),
                  Center(
                    child: Text(
                      "LogIn",
                      style: GoogleFonts.amiriQuran(
                        fontSize: 30.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: () async {
                      await _auth.loginWithGoogle();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Mainpage(),
                          ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "You are Successfully Logged In With Google"),
                        ),
                      );
                    },
                    child: Container(
                      height: 6.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 245, 0.349),
                          borderRadius: BorderRadius.circular(5.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4.h,
                            width: 8.w,
                            child: Image.asset("assets/images/google.png"),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            "LogIn with Google",
                            style: GoogleFonts.alatsi(
                                fontSize: 14.sp, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          endIndent: 3.w,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Or",
                        style: TextStyle(color: Colors.white, fontSize: 15.sp),
                      ),
                      Expanded(
                        child: Divider(
                          indent: 3.w,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  TextFormField(
                    controller: email,
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
                  SizedBox(height: 3.h),
                  TextFormField(
                    controller: pass,
                    obscureText: true,
                    style: GoogleFonts.alatsi(color: Colors.white),
                    cursorColor: Colors.white,
                    cursorWidth: 2.sp,
                    decoration: InputDecoration(
                        labelText: "Password",
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
                  Padding(
                    padding: EdgeInsets.only(left: 22.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const forgotpassd(),
                        ));
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: GoogleFonts.amiriQuran(
                          fontSize: 13.sp,
                          letterSpacing: 1.0,
                          color: const Color.fromARGB(255, 26, 166, 89),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  GestureDetector(
                    onTap: _login,
                    child: Container(
                      height: 5.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 26, 166, 89),
                          borderRadius: BorderRadius.circular(5.sp)),
                      child: Center(
                        child: Text(
                          "LogIn",
                          style: GoogleFonts.alatsi(
                              fontSize: 18.sp, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an Account ?",
                        style: GoogleFonts.amiriQuran(
                          fontSize: 13.sp,
                          color: Colors.grey[200],
                        ),
                      ),
                      SizedBox(width: 2.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Signupsrn(),
                          ));
                        },
                        child: Text(
                          "SignUp",
                          style: GoogleFonts.amiriQuran(
                            fontSize: 13.sp,
                            letterSpacing: 1.0,
                            color: const Color.fromARGB(255, 26, 166, 89),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _login() async {
    if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your email"),
        ),
      );
      return;
    }

    if (pass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your password"),
        ),
      );
      return;
    }

    try {
      await _auth.loginUserWithWithEmailAndPassword(email.text, pass.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Successful"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
