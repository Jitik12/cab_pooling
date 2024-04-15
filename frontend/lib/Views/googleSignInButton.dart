import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/constants/colors.dart';
import 'package:swift_street/constants/routes.dart';
import 'package:swift_street/services/auth/auth_service.dart';
import 'dart:developer' as devtools;

Widget googleSignInButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: OutlinedButton(
      onPressed: () async {
        try {
          AuthService().signInWithGoogle()
            .then((value)=>Navigator.pushReplacementNamed(context, homeRoute));
        } on PlatformException catch (e) {
          devtools.log('Error occurred ${e.message}', name: 'LoginScreen');
        }
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side:const  BorderSide(width: 1, color: black54),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/google_logo.png', height: 25.0),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Continue with Google',
              style: GoogleFonts.urbanist(
                fontSize: 17,
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
