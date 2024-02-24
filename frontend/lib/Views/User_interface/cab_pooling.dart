import 'package:flutter/material.dart';
import 'package:swift_street/Views/User_interface/BottomSheets/cab_pool_page_one.dart';
import 'package:swift_street/Widgets/bottom_sheet.dart';

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
            bottom: screenHeight / 10,
            right: screenWidth / 10,
            child: IconButton(
              icon: const Icon(
                Icons.location_searching,
              ),
              onPressed: () {},
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
          ScrollableBottomSheet(
            minSheetSize: 36 / screenHeight,
            maxSheetSize: 0.6,
            dragable: true,
            child: CarPoolPageOne(
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
