import 'dart:convert';

import 'package:CabX/Widgets/bookings_card.dart';
import 'package:CabX/Widgets/heading_with_more.dart';
import 'package:CabX/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:CabX/services/auth/auth_service.dart';
import 'package:intl/intl.dart';

class BookingSection extends StatefulWidget {
  const BookingSection({Key? key}) : super(key: key);

  @override
  State<BookingSection> createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  final int _upcomingNum = 4;
  final int _historyNum = 2;
  final String backend_url = "https://dhruvin-cabs.jitik.online:8000";

  List<Map<String, dynamic>> upcomingRides = [];
  String auth_email = AuthService().currentUser!.email;

  @override
  void initState() {
    super.initState();
    fetchUpcomingRides(auth_email);
  }

  Future<void> fetchUpcomingRides(String email) async {
    try {
      Map<String, dynamic> requestData = {"email": email};
      final response = await http.post(
        Uri.parse("$backend_url/get_my_pool_customer"),
        body: jsonEncode(requestData),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        setState(() {
          upcomingRides = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        throw Exception('Failed to fetch upcoming rides');
      }
    } catch (e) {
      print('Error fetching upcoming rides: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: upcomingRides.length,
      itemBuilder: (context, index) {
        final ride = upcomingRides[index];
        return getBookingCard(
          destination: ride['destination'],
          pickup: ride['start'],
          time: DateFormat("yyyy-MM-dd hh:mm a").parse("${ride['date']} ${ride['time']}"),
          imagePath: 'assets/images/home_section/location.png',
          onTap: () {
            Navigator.of(context).pushNamed(rideDetails);
          },
        );
      },
    );
  }
}
