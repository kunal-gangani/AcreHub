import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;
  final FormFieldValidator validator;
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7.w, right: 7.w),
      child: TextFormField(
        controller: textEditingController,
        enableSuggestions: true,
        keyboardType: textInputType,
        style: GoogleFonts.montserrat(color: Colors.white),
        cursorColor: Colors.white,
        cursorWidth: 2.sp,
        validator: validator,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(1.h),
            hintText: hintText,
            hintStyle:
                GoogleFonts.montserrat(fontSize: 15.sp, color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.sp)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 2.sp)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.sp),
            )),
      ),
    );
  }
}
