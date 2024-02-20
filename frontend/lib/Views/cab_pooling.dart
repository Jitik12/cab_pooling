import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/iconedButton.dart';
import 'package:swift_street/Widgets/input_field.dart';
import 'package:swift_street/enums/time_slot.dart';

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
  double _sheetPosition = 0.5;
  double sheetPadding = 16;
  int num_people = 1;

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
          Positioned(
            top: screenHeight / 3,
            right: screenWidth / 20,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.my_location_rounded,
                color: Colors.black,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  const CircleBorder(),
                ),
                maximumSize: MaterialStateProperty.all(const Size(40, 40)),
              ),
            ),
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
                                    text: num_people.toString(),
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
                                  text: '11:15 AM',
                                  suffixIcon: Icons.arrow_drop_down,
                                  onPressed: () {},
                                ),
                                iconedButton(
                                  prefixIcon: Icons.date_range,
                                  text: '22 Jan, 2024',
                                  suffixIcon: Icons.arrow_drop_down,
                                  onPressed: () {},
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(children: [
                              TextPrefixedButton(
                                text: 'Time Slot',
                                enumValue: TimeSlot.hour_1,
                                onPressed: () {},
                                icon: Icons.arrow_drop_down,
                              ),
                              const SizedBox(width: 16),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'See how Slot works',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ]),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(children: [
                              TextPrefixedButton(
                                text: 'Number of People to Pool',
                                enumValue: TimeSlot.hour_1,
                                onPressed: () {},
                                icon: Icons.arrow_drop_down,
                              ),
                            ])
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

class Grabber extends StatelessWidget {
  const Grabber({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15.0),
          width: 36.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}

Widget locationInput({
  required String hintText,
  required TextEditingController controller,
  required double width,
  required IconData icon,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        color: Colors.black,
        size: 20.0,
      ),
      const SizedBox(width: 10),
      SizedBox(
        width: width,
        height: 50,
        child: InputField(
          hintText: hintText,
          controller: controller,
          args: {
            'keyboardType': TextInputType.streetAddress,
            'contentPadding': const EdgeInsets.all(10.0),
            'alignment': TextAlign.start,
            'hintSize': 18.0,
          },
        ),
      )
    ],
  );
}

class TextPrefixedButton<E> extends StatelessWidget {
  final String text;
  final TimeSlot enumValue;
  final Function() onPressed;
  final IconData icon;
  const TextPrefixedButton(
      {super.key,
      required this.text,
      required this.enumValue,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.black54),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  enumValue.name.toString().split('.').last,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
