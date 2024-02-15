import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CabPoolingPage extends StatefulWidget {
  const CabPoolingPage({super.key});

  @override
  State<CabPoolingPage> createState() => _CabPoolingPageState();
}

class _CabPoolingPageState extends State<CabPoolingPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          Positioned(
            top: screenHeight / 2.5,
            child: GestureDetector(
              onVerticalDragStart: (details) {},
              child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Icon(
                            Icons.remove_rounded,
                            color: Colors.grey,
                            size: 20.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Choose Your destination",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                ),
                              ),

                              // need to add a drop down menu

                            ])
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
