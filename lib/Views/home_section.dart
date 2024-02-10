import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/input_field.dart';
import 'package:swift_street/Widgets/place_card.dart';

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
    return Column(
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
              imagePath: 'assets/images/RGIA.png',
              width: (screenWidth - 40) / 2,
            ),
            getPlaceCard(
              placeName: 'Secunderabad',
              time: '1hr 36min',
              imagePath: 'assets/images/train.png',
              width: (screenWidth - 40) / 2,
            ),
          ],
        )
      ],
    );
  }
}
