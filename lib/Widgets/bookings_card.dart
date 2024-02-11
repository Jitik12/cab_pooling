import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget getBookingCard({
  required String destination,
  required String pickup,
  required DateTime time,
  required String imagePath,
}) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 8, left: 12, right: 12, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image(image: AssetImage(imagePath)),
              const SizedBox(height: 15),
              Text(
                destination,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('From',
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                      )),
                  const SizedBox(width: 10),
                  Text(pickup,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                      )),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('12:00 PM',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_right_alt,
                      color: Colors.black, size: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
