import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/dialog/ok_dialog.dart';
import 'package:swift_street/Widgets/grabber.dart';
import 'package:swift_street/Widgets/iconedButton.dart';
import 'package:swift_street/Widgets/location_input.dart';
import 'package:swift_street/Widgets/text_prefixed_button.dart';
import 'package:swift_street/enums/num_people.dart';
import 'package:swift_street/enums/time_slot.dart';
import 'package:intl/intl.dart';

class CabPoolingPage extends StatefulWidget {
  const CabPoolingPage({super.key});

  @override
  State<CabPoolingPage> createState() => _CabPoolingPageState();
}

class _CabPoolingPageState extends State<CabPoolingPage> {
  late final TextEditingController
      startController; // Declare the TextEditingController
  late final TextEditingController
      destinationController; // Declare the TextEditingController
  double _sheetPosition = 0.6;
  double sheetPadding = 16;
  TimeSlot timeSlot = TimeSlot.hour_1;
  NumPeople num_people = NumPeople.one;

  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
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

  Future<DateTime> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2025));

    if (pickedDate != null) {
      return pickedDate;
    }

    return date;
  }

  Future<TimeOfDay> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      errorInvalidText: '12 hour format',
      initialTime: time,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      return picked;
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/images/cab_pooling/map.png'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: screenHeight / 20,
            left: screenWidth / 20,
            child: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
                maximumSize: MaterialStateProperty.all(const Size(40, 40)),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            mini: true,
            child: const Icon(Icons.my_location_rounded,
                color: Colors.black, size: 20),
          ),
          DraggableScrollableSheet(
            initialChildSize: _sheetPosition,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: sheetPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Grabber(),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Choose your destination',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  iconedButton(
                                    prefixIcon: Icons.people_outline,
                                    text: num_people.value,
                                    suffixIcon: Icons.arrow_drop_down,
                                    onPressed: () {},
                                  )
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                iconedButton(
                                  prefixIcon: Icons.timer,
                                  text:
                                      "${time.hour}:${time.minute < 10 ? '0' : ''}${time.minute} ${time.period.index == 0 ? 'AM' : 'PM'}",
                                  onPressed: () async {
                                    time = await selectTime(context);
                                    setState(() {
                                      time = time;
                                    });
                                  },
                                ),
                                iconedButton(
                                  prefixIcon: Icons.date_range,
                                  text: DateFormat('dd/MM/yyyy')
                                      .format(date)
                                      .toString(), // 22 jan 2024
                                  onPressed: () async {
                                    date = await selectDate();
                                    setState(() {
                                      date = date;
                                    });
                                  },
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(children: [
                              TextPrefixedButton(
                                text: 'Time Slot',
                                value: TimeSlot.hour_1.value,
                                onPressed: () {},
                                icon: Icons.arrow_drop_down,
                              ),
                              const SizedBox(width: 16),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'See how Slot works',
                                  style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ]),
                            const SizedBox(
                              height: 15,
                            ),
                            TextPrefixedButton(
                              text: 'Number of People to Pool',
                              value: NumPeople.one.value,
                              onPressed: () {},
                              icon: Icons.arrow_drop_down,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                                'The number of people can change at the time of ride',
                                style: GoogleFonts.poppins(
                                  color:
                                      const Color.fromARGB(255, 176, 171, 171),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                )),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  int totalTime = date.millisecondsSinceEpoch +
                                      time.hour * 60 * 60 * 1000 +
                                      time.minute * 60 * 1000;

                                  int currentTime =
                                      DateTime.now().millisecondsSinceEpoch;

                                  if (totalTime < currentTime) {
                                    await showOkDialog(
                                      context: context,
                                      title: 'Invalid Time',
                                      content:
                                          'Please select a time in the future',
                                    );
                                    return;
                                  }
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
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
