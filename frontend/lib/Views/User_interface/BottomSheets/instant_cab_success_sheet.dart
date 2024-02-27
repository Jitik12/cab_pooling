import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/green_button.dart';

class InstantCabSuccessSheet extends StatelessWidget {
  const InstantCabSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Congrats!',
        style: GoogleFonts.poppins(
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Center(child: Image.asset('assets/images/booked.png', width: 100)),
      const SizedBox(
        height: 22,
      ),
      Center(
        child: Text(
          'Your Ride has been Pooled!',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      GreenButton(onPressed: (){},
      title: 'Ride Details',
      ),
    ]);
  }
}
