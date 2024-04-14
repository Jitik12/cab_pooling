import 'package:flutter/material.dart';
import 'package:swift_street/Views/BottomSheets/instant_cab_success_sheet.dart';
import 'package:swift_street/Views/BottomSheets/instant_cabs_review_sheet.dart';
import 'package:swift_street/Views/BottomSheets/instant_cabs_sheet_one.dart';
import 'package:swift_street/Views/BottomSheets/trip_pool_review_sheet.dart';
import 'package:swift_street/Views/BottomSheets/trip_pool_sheet_one.dart';
import 'package:swift_street/Views/BottomSheets/trip_pool_succes_sheet.dart';
import 'package:swift_street/Views/edit_payment_details.dart';
import 'package:swift_street/Views/edit_profile.dart';
import 'package:swift_street/Views/home_page.dart';
import 'package:swift_street/Views/map_page.dart';
import 'package:swift_street/Views/payment_details.dart';
import 'package:swift_street/Views/ride_details.dart';
import 'package:swift_street/constants/routes.dart';
import 'package:swift_street/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      title: 'CabPool',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        tripPoolingHome: (context) => const MapPage(
            sheetContent: TripPoolSheetOne(),
            maxSheetSize: 0.6,
            dragable: true),
        instantCabHome: (context) => const MapPage(
            sheetContent: InstantCabSheetOne(),
            dragable: true,
            maxSheetSize: 0.45),
        tripPoolingReviewPage: (context) => MapPage(
            sheetContent: TripPoolReviewSheet(),
            dragable: true,
            maxSheetSize: 0.48),
        instantCabReviewPage: (context) => MapPage(
            sheetContent: InstantCabsReviewSheet(),
            dragable: true,
            maxSheetSize: 0.6),
        instantCabConfirmationPage: (context) => const MapPage(
            sheetContent: InstantCabSuccessSheet(),
            dragable: true,
            maxSheetSize: 0.45),
        tripPoolConfirmationPage: (context) => const MapPage(
            sheetContent: TripPoolSuccessSheet(),
            dragable: true,
            maxSheetSize: 0.65),
        editProfile: (context) => const EditProfilePage(),
        paymentDetails: (context) => const PaymentDetailsPage(),
        editPayment: (context) => const EditPaymentPage(),
        rideDetails: (context) => RideDetails(),
      }));
}
