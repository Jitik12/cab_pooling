import 'package:CabX/Widgets/customized_popup_menu.dart';
import 'package:CabX/Widgets/dialog/ok_dialog.dart';
import 'package:CabX/Widgets/green_button.dart';
import 'package:CabX/Widgets/iconedButton.dart';
import 'package:CabX/Widgets/location_input.dart';
import 'package:CabX/constants/colors.dart';
import 'package:CabX/constants/routes.dart';
import 'package:CabX/constants/sheet_padding.dart';
import 'package:CabX/data/CabPoolRequest.dart';
import 'package:CabX/enums/num_people.dart';
import 'package:CabX/enums/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;


class TripPoolSheetOne extends StatefulWidget {
  const TripPoolSheetOne({super.key});

  @override
  State<TripPoolSheetOne> createState() => _TripPoolSheetOneState();
}

class _TripPoolSheetOneState extends State<TripPoolSheetOne> {
  late final TextEditingController
      startController; // Declare the TextEditingController
  late final TextEditingController
      destinationController; // Declare the TextEditingController

  CabPoolRequest cabPoolRequest = CabPoolRequest();

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
            value: cabPoolRequest.num1,
            options: NumPeople.values,
            onOptionSelected: (value) {
              setState(() {
                cabPoolRequest.num1 = value;
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
            onTap: () {
              // Navigator.pushNamed(context, setMarkerPage);
            }),
        const SizedBox(height: 10),
        locationInput(
            hintText: 'Destination',
            controller: destinationController,
            width: screenWidth - 2 * sheetPadding - 30,
            icon: Icons.location_on,
            onTap: () {
              print('helo');
              // Navigator.pushNamed(context, setMarkerPage);
            }),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconedButton(
              prefixIcon: Icons.timer,
              text:
                  "${cabPoolRequest.time.hour}:${cabPoolRequest.time.minute < 10 ? '0' : ''}${cabPoolRequest.time.minute} ${cabPoolRequest.time.period.index == 0 ? 'AM' : 'PM'}",
              onPressed: () async {
                await selectTime(context);
              },
            ),
            iconedButton(
              prefixIcon: Icons.date_range,
              text: DateFormat('dd/MM/yyyy')
                  .format(cabPoolRequest.date)
                  .toString(), // 22 jan 2024
              onPressed: () async {
                await selectDate();
              },
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(children: [
          CustomizedPopUpMenu<int>(
            text: 'Time Slot',
            value: cabPoolRequest.timeSlot,
            options: List.generate(24, (index) => index), // Options from 0 to 23
            onOptionSelected: (value) {
              setState(() {
                cabPoolRequest.timeSlot = value;
              });
            },
            getLabel: (value) => '$value:00',
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'See how Slot works',
              style: GoogleFonts.poppins(
                color: black54,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ]),
        const SizedBox(
          height: 15,
        ),
        CustomizedPopUpMenu<NumPeople>(
          text: 'Number of people to pool',
          value: cabPoolRequest.numpeople,
          options: NumPeople.values,
          onOptionSelected: (value) {
            setState(() {
              cabPoolRequest.numpeople = value;
            });
          },
          getLabel: (value) => value.value,
        ),
        const SizedBox(
          height: 15,
        ),
        Text('The number of people can change at the time of ride',
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 176, 171, 171),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 10),
        GreenButton(
          onPressed: () async {
            int totalTime = cabPoolRequest.date.millisecondsSinceEpoch +
                cabPoolRequest.time.hour * 60 * 60 * 1000 +
                cabPoolRequest.time.minute * 60 * 1000 +
                (cabPoolRequest.time.period.index == 0
                    ? 0
                    : 12 * 60 * 60 * 1000);

            int currentTime = DateTime.now().millisecondsSinceEpoch;

            if (totalTime < currentTime) {
              await showOkDialog(
                context: context,
                title: 'Invalid Time',
                content: 'Please select a time in the future',
              );
              return;
            }
            // Armaan : Creating a pool request to the server
            cabPoolRequest.start = startController.text;
            cabPoolRequest.destination = destinationController.text;

            Map<String, dynamic> requestBody = cabPoolRequest.toJsonForRegister();

            // Make the POST request
            try {
              String backendUrl = "https://dhruvin-cabs.jitik.online:8000";
              print(backendUrl);
              // Define your server URL
              Uri url = Uri.parse(backendUrl);

              // Make the POST request
              http.Response response = await http.post(
                url,
                body: requestBody,
              );

              // Check the response status
              if (response.statusCode == 200) {
                // Request successful, navigate to the review page
                Navigator.of(context).pushNamed(tripPoolingReviewPage);
              } else {
                // Request failed, show an error dialog
                await showOkDialog(
                  context: context,
                  title: 'Error',
                  content: 'An error occurred while processing your request. Please try again later.',
                );
              }
            } catch (e) {
              // Handle any errors that occur during the request
              print('Error making request: $e');
              await showOkDialog(
                context: context,
                title: 'Error',
                content: 'An error occurred while processing your request. Please try again later.',
              );
            }

          },
          title: 'Book the Ride',
        )
      ],
    );
  }

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2025));

    if (pickedDate != null) {
      cabPoolRequest.date = pickedDate;
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      errorInvalidText: '12 hour format',
      initialTime: cabPoolRequest.time,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      cabPoolRequest.time = picked;
    }
  }
}
