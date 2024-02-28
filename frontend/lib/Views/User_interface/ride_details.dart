import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/Ride%20Details%20Widgets/copassenger_details.dart';
import 'package:swift_street/Widgets/review_row.dart';
import 'package:swift_street/constants/colors.dart';
import 'package:swift_street/data/CoPassengerDetails.dart';

class RideDetails extends StatelessWidget {
  RideDetails({super.key});
  final List<CoPassengerData> passengers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: blueColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Ride Details',
          style: GoogleFonts.poppins(
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'RGIA Hyderabad',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: blueShade),
                      ),
                      Text(
                        'pickup IIT Hyderabad',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: blueShade,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.share,
                    size: 24.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Image.asset(
                  'assets/images/ride_details_img.png',
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Driver Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Center(
                child: Text(
                  'No Driver assigned',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'You can contact pooled passengers and book your own cab',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: greyShade,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Trip Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              getReviewRow(name: 'Price', value: 'Rs. 2000'),
              const SizedBox(
                height: 18,
              ),
              getReviewRow(name: 'Start', value: 'RGIA Hyderabad'),
              const SizedBox(
                height: 10,
              ),
              getReviewRow(name: 'End', value: 'IIT Hyderabad'),
              const SizedBox(
                height: 18,
              ),
              getReviewRow(name: 'Date', value: '16th Jan 2024'),
              const SizedBox(
                height: 10,
              ),
              getReviewRow(name: 'Time', value: '11:54 AM'),
              const SizedBox(
                height: 15,
              ),
              CoPassengerDetailsWidget(
                passengers: passengers,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
