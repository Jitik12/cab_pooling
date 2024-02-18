import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swift_street/Widgets/iconedButton.dart';
import 'package:swift_street/Widgets/input_field.dart';

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
  double _sheetPosition = 0.4;

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
              return GestureDetector(
                onVerticalDragUpdate: (details) {
                  double dy = details.delta.dy;

                  setState(() {
                    if (dy > 0) {
                      _sheetPosition = 0.4;
                    } else {
                      _sheetPosition = 0.8;
                    }
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const Grabber(),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Choose your destination',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_searching,
                                      color: Colors.black, size: 20.0),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: screenWidth - 54,
                                    height: 50,
                                    child: InputField(
                                      hintText: 'Start',
                                      controller: startController,
                                      args: {
                                        'keyboardType':
                                            TextInputType.streetAddress,
                                        'contentPadding':
                                            const EdgeInsets.all(10.0),
                                        'alignment': TextAlign.start,
                                        'hintSize': 18.0,
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.black, size: 20.0),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: screenWidth - 54,
                                    height: 50,
                                    child: InputField(
                                      hintText: 'Destination',
                                      controller: destinationController,
                                      args: {
                                        'keyboardType':
                                            TextInputType.streetAddress,
                                        'contentPadding':
                                            const EdgeInsets.all(10.0),
                                        'alignment': TextAlign.start,
                                        'hintSize': 18.0,
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
    return GestureDetector(
      child: Container(
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
      ),
    );
  }
}
