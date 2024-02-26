import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripPoolSuccessSheet extends StatelessWidget {
  const TripPoolSuccessSheet({super.key});

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
        child: Column(
          children: [
            Text(
              'Your Ride has been booked!',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 15,
            ),

             Text(
              'Your Ride has been booked!',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 18, 209, 142),
            ),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 15,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          child: const Text(
            'Ride Details',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ]);
  }
}
