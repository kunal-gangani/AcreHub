import 'package:acrehub/auth/auth_sevice.dart';
import 'package:acrehub/auth/login.dart';
import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Signupsrn extends StatefulWidget {
  const Signupsrn({super.key});

  @override
  State<Signupsrn> createState() => _SignupsrnState();
}

class _SignupsrnState extends State<Signupsrn> {
  final _auth = AuthSevice();

  TextEditingController usernme = TextEditingController();
  TextEditingController semail = TextEditingController();
  TextEditingController spass = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Add GlobalKey for form validation

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Lrbgclr(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 7.w, right: 7.w),
              child: Form(
                // Wrap with Form widget
                key: _formKey, // Add form key
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Center(
                      child: Text(
                        "SignUp",
                        style: GoogleFonts.amiriQuran(
                          fontSize: 38.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loginsrn(),
                          ),
                        );
                      },
                      child: Container(
                        height: 6.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 245, 0.349),
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
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
                              "SignUp with Google",
                              style: GoogleFonts.alatsi(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
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
                          style:
                              TextStyle(color: Colors.white, fontSize: 15.sp),
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
                      controller: usernme,
                      enableSuggestions: true,
                      keyboardType: TextInputType.name,
                      style: GoogleFonts.alatsi(color: Colors.white),
                      cursorColor: Colors.white,
                      cursorWidth: 2.sp,
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3.h),
                    TextFormField(
                      controller: semail,
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
                              BorderSide(color: Colors.white, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 3.h),
                    TextFormField(
                      controller: spass,
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
                              BorderSide(color: Colors.white, width: 2.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.sp),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: _signup,
                      child: Container(
                        height: 5.h,
                        width: 35.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 26, 166, 89),
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                        child: Center(
                          child: Text(
                            "SignUp",
                            style: GoogleFonts.alatsi(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account ?",
                          style: GoogleFonts.amiriQuran(
                            fontSize: 13.sp,
                            color: Colors.grey[200],
                          ),
                        ),
                        SizedBox(width: 2.w),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Loginsrn(),
                            ));
                          },
                          child: Text(
                            "LogIn",
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
          ),
        )
      ],
    );
  }

  _signup() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with sign up
      await _auth.createUserWithWithEmailAndPassword(semail.text, spass.text);
      Navigator.pop(context);
    }
  }
}
