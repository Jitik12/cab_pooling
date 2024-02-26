import 'package:flutter/material.dart';
import 'package:swift_street/Views/User_interface/BottomSheets/instant_cab_success_sheet.dart';
import 'package:swift_street/Views/User_interface/BottomSheets/instant_cabs_review_sheet.dart';
import 'package:swift_street/Views/User_interface/BottomSheets/instant_cabs_sheet_one.dart';
import 'package:swift_street/Views/User_interface/BottomSheets/trip_pool_review_sheet.dart';
import 'package:swift_street/Views/User_interface/BottomSheets/trip_pool_sheet_one.dart';
import 'package:swift_street/Views/User_interface/map_page.dart';
import 'package:swift_street/Views/User_interface/home_page.dart';
import 'package:swift_street/constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      title: 'CabPool',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        home: (context) => const HomePage(),
        tripPoolingHome: (context) => const MapPage(
            sheetContent: TripPoolSheetOne(),
            maxSheetSize: 0.6,
            dragable: true),
        instantCabHome: (context) => const MapPage(
            sheetContent: InstantCabSheetOne(),
            dragable: true,
            maxSheetSize: 0.43),
        tripPoolingReviewPage: (context) => MapPage(
            sheetContent: TripPoolReviewSheet(),
            dragable: true,
            maxSheetSize: 0.5),
        instantCabReviewPage: (context) => MapPage(
            sheetContent: InstantCabsReviewSheet(),
            dragable: true,
            maxSheetSize: 0.6),
        instantCabConfirmationPage: (context) => const MapPage(
            sheetContent: InstantCabSuccessSheet(),
            dragable: true,
            maxSheetSize: 0.45),
      }));
}
