import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: non_constant_identifier_names
Widget InputField({
  required String hintText,
  required TextEditingController controller,
  Map<String, dynamic>? args,
}) {
  final keyBoardType =
      args?['keyboardType'] as TextInputType? ?? TextInputType.text;
  final alignment = args?['alignment'] as TextAlign? ?? TextAlign.start;
  final isObscure = args?['isObscure'] as bool? ?? false;
  final Icon? prefixIcon = args?['prefixIcon'] as Icon?;
  final hintSize = args?['hintSize'] as double? ?? 20;
  final hintWeight = args?['hintWeight'] as FontWeight? ?? FontWeight.w500;

  final contentPadding = args?['contentPadding'] as EdgeInsets? ;
  return TextField(
    controller: controller,
    textAlign: alignment,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: hintSize,
        fontWeight: hintWeight,
      ),
      contentPadding: contentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    keyboardType: keyBoardType,
    obscureText: isObscure,
  );
}
