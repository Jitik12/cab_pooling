import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/review_row.dart';

// ignore: must_be_immutable
class TripPoolReviewSheet extends StatelessWidget {
  Map<String, dynamic> cabDetails = {
    "Expected Price": "Rs 2000.00",
    "Travel Time": "1500 hr",
    "Pickup Point": "Kathmandu",
    "Time Slot": "1:30 - 3:30",
  };
  TripPoolReviewSheet({super.key});
  final price = 2000;

  @override
  Widget build(BuildContext context) {
    final rows = List.from(
      cabDetails.entries.map(
        (e) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: getReviewRow(
            name: e.key,
            value: e.value.toString(),
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review Your Trip',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 22,
        ),
        ...rows,
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Price will be calculated based on the number of passengers and wil be confirmed with you before the ride',
          style: TextStyle(
              fontSize: 12, color: Color.fromARGB(255, 163, 157, 157)),
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
              'Book the Ride',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
