import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/customized_popup_menu.dart';
import 'package:swift_street/Widgets/location_input.dart';
import 'package:swift_street/constants/sheet_padding.dart';
import 'package:swift_street/data/InstantCabRequest.dart';
import 'package:swift_street/enums/instant_time.dart';
import 'package:swift_street/enums/num_people.dart';
import 'package:swift_street/constants/routes.dart';

class InstantCabSheetOne extends StatefulWidget {
  const InstantCabSheetOne({super.key});

  @override
  State<InstantCabSheetOne> createState() => _InstantCabSheetOneState();
}

class _InstantCabSheetOneState extends State<InstantCabSheetOne> {
  late final TextEditingController
      startController; // Declare the TextEditingController
  late final TextEditingController
      destinationController; // Declare the TextEditingController

  InstantCabRequest instantCabRequest = InstantCabRequest();

  @override
  void initState() {
    super.initState();
    startController =
        TextEditingController(); // Initialize the TextEditingController
    destinationController = TextEditingController();
  }

  @override
  void dispose() {
    startController
        .dispose(); // Dispose the TextEditingController when not needed
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Choose your destination',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          CustomizedPopUpMenu<NumPeople>(
            prefixIcon: Icons.people,
            value: instantCabRequest.numpeople,
            options: NumPeople.values,
            onOptionSelected: (value) {
              setState(() {
                instantCabRequest.numpeople = value;
              });
            },
            getLabel: (value) => value.value,
          ),
        ]),
        const SizedBox(height: 15),
        locationInput(
          hintText: 'Start',
          controller: startController,
          width: screenWidth - 2 * sheetPadding - 30,
          icon: Icons.location_searching,
        ),
        const SizedBox(height: 10),
        locationInput(
          hintText: 'Destination',
          controller: destinationController,
          width: screenWidth - 2 * sheetPadding - 30,
          icon: Icons.location_on,
        ),
        const SizedBox(height: 15),
        CustomizedPopUpMenu<InstantTime>(
          prefixIcon: Icons.people,
          value: instantCabRequest.instantTime,
          options: InstantTime.values,
          onOptionSelected: (value) {
            setState(() {
              instantCabRequest.instantTime = value;
            });
          },
          getLabel: (value) => value.label,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              instantCabRequest.start = startController.text;
              instantCabRequest.destination = destinationController.text;

              Navigator.of(context).pushNamed(instantCabReviewPage);
            },
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
