// ignore_for_file: camel_case_types

import 'package:acrehub/widgets/lrbgclr.dart';
import 'package:acrehub/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class splashsrn extends StatefulWidget {
  const splashsrn({super.key});

  @override
  State<splashsrn> createState() => _splashsrnState();
}

class _splashsrnState extends State<splashsrn> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Wrapper()),
          (Route<dynamic> route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Bgclr(),
      const Lrbgclr(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SizedBox(
            height: 50.h,
            width: 50.w,
            child: Image.asset(
              "assets/images/Logo.png",
            ),
          ),
        ),
      ),
    ]);
  }
}
