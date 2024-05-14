import 'package:CabX/Widgets/green_button.dart';
import 'package:CabX/Widgets/review_row.dart';
import 'package:CabX/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TripPoolReviewSheet extends StatelessWidget {
  const TripPoolReviewSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> cabDetails =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
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
          'Price will be calculated based on the number of passengers and will be confirmed with you before the ride',
          style: TextStyle(
              fontSize: 12, color: Color.fromARGB(255, 163, 157, 157)),
        ),
        const SizedBox(
          height: 20,
        ),
        GreenButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, (route) => false);
          },
          title: 'Ride Booked',
        ),
      ],
    );
  }
}
