import 'dart:convert';

import 'package:CabX/Widgets/Ride%20Details%20Widgets/copassenger_details.dart';
import 'package:CabX/Widgets/Ride%20Details%20Widgets/driver_details.dart';
import 'package:CabX/Widgets/review_row.dart';
import 'package:CabX/constants/colors.dart';
import 'package:CabX/data/CoPassengerDetails.dart';
import 'package:CabX/data/DriverDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RideDetails extends StatefulWidget {
  const RideDetails({Key? key}) : super(key: key);

  @override
  _RideDetailsState createState() => _RideDetailsState();
}

class _RideDetailsState extends State<RideDetails> {
  late int poolId;
  static const String backendUrl = "https://dhruvin-cabs.jitik.online:8000";
  late Uri url;
  Map<String, dynamic> rideDetails = {};
  late Future<Map<String, dynamic>> _rideDetailsFuture;


  @override
  void initState() {
    super.initState();
    // Defer accessing ModalRoute.of(context) until after the build method
    // by scheduling the initialization in a post-frame callback.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      poolId = ModalRoute.of(context)!.settings.arguments as int;
      url = Uri.parse("$backendUrl/specific_pool");
      _rideDetailsFuture = fetchData(poolId, url);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access route arguments and fetch data here
    poolId = ModalRoute.of(context)!.settings.arguments as int;
    url = Uri.parse("$backendUrl/specific_pool");
    fetchData(poolId, url);
  }


  Future<Map<String, dynamic>> fetchData(int poolId, Uri url) async {
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'pool_id': poolId}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        shadowColor: blackColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: blackColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Ride Details',
          style: GoogleFonts.poppins(
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 30,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _rideDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            rideDetails = snapshot.data ?? {};
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (rideDetails['start'] != null)
                            Text(
                              'Start: ${rideDetails['start']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: blueShade,
                              ),
                            ),
                          if (rideDetails['destination'] != null)
                            Text(
                              'End: ${rideDetails['destination']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: blueShade,
                              ),
                            ),
                        ],
                      ),
                      const Icon(
                        Icons.share,
                        size: 24.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/images/ride_details_img.png',
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 10),
                  if (rideDetails['driver'] != null)
                    DriverDetailsWidget(
                      driverDetails: DriverDetails(
                        name: rideDetails['driver']['name'],
                        phone: rideDetails['driver']['phone'],
                        vehicleNumber: rideDetails['driver']['car_no'],
                        vehicleMake: rideDetails['driver']['car_model'],
                      ),
                    ),
                  SizedBox(height: 15),
                  Text(
                    'Trip Details',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  getReviewRow(name: 'Price', value: "2000"),
                  SizedBox(height: 18),
                  if (rideDetails['date'] != null)
                    getReviewRow(name: 'Date', value: rideDetails['date']),
                  SizedBox(height: 10),
                  if (rideDetails['time'] != null)
                    getReviewRow(name: 'Time', value: rideDetails['time']),
                  SizedBox(height: 15),
                  Text(
                    'Passengers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 15),
                  if (rideDetails['people'] != null)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: rideDetails['people'].length,
                      itemBuilder: (context, index) {
                        final passenger = rideDetails['people'][index];
                        return ListTile(
                          title: Text(passenger['name'] ?? ''),
                          subtitle: Text(passenger['phone'] ?? ''),
                          leading: CircleAvatar(
                            backgroundImage:
                            NetworkImage(passenger['photoURL'] ?? ''),
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}