import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/bookings_card.dart';
import 'package:swift_street/Widgets/feature_card.dart';
import 'package:swift_street/Widgets/input_field.dart';
import 'package:swift_street/Widgets/place_card.dart';
import 'package:swift_street/constants/routes.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  late final TextEditingController _destinationController;

  @override
  void initState() {
    _destinationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          InputField(
            hintText: 'Start Your Ride',
            controller: _destinationController,
            args: {
              'keyboardType': TextInputType.name,
              'alignment': TextAlign.center,
              'prefixIcon':
                  const Icon(Icons.search, color: Colors.black, size: 30.0),
              'hintSize': 20.0,
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getPlaceCard(
                placeName: 'RGIA Hyderabad',
                time: '1hr 36 min',
                imagePath: 'assets/images/home_section/RGIA.png',
                width: (screenWidth - 40) / 2,
              ),
              getPlaceCard(
                placeName: 'Secunderabad',
                time: '1hr 36min',
                imagePath: 'assets/images/home_section/train.png',
                width: (screenWidth - 40) / 2,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Services',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: getFeatureCard(
                  width: (screenWidth - 40) / 2,
                  text: 'Trip Pooling',
                  imagePath: 'assets/images/home_section/tesla_left.png',
                  alignment: MainAxisAlignment.end,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(cabPoolingHome);
                },
              ),
              getFeatureCard(
                width: (screenWidth - 40) / 2,
                text: 'Instant Cabs',
                imagePath: 'assets/images/home_section/tesla_right.png',
                alignment: MainAxisAlignment.start,
                icon: 'assets/images/home_section/24_7.png',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Upcoming',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '2',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          getBookingCard(
            destination: 'Secunderabad Railway Station',
            pickup: 'IIT Hyderabad',
            time: DateTime(1969, 7, 20, 20, 18, 04),
            imagePath: 'assets/images/home_section/location.png',
          ),
          getBookingCard(
            destination: 'RGIA Hyderabad',
            pickup: 'IIT Hyderabad',
            time: DateTime(1969, 7, 20, 20, 18, 04),
            imagePath: 'assets/images/home_section/location.png',
          ),
        ],
      ),
    );
  }
}
