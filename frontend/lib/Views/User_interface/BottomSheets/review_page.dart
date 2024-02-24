import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO 
class CabReview extends StatelessWidget {
  const CabReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column( children: [
      Text(
        'Review Your Trip',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),

      ),

      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

        ],
      ),
    ],);
  }
}
