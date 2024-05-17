import 'dart:convert';
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
  Map<String, dynamic>? rideDetails;

  @override
  void initState() {
    super.initState();
    // Schedule the fetching of data after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Grab the pool_id from route arguments
      poolId = ModalRoute.of(context)!.settings.arguments as int;
      // Send request to server
      fetchRideDetails(poolId);
    });
  }

  Future<void> fetchRideDetails(int poolId) async {
    url = Uri.parse("$backendUrl/specific_pool");
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'pool_id': poolId}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          rideDetails = jsonDecode(response.body);
        });
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        rideDetails = {'error': 'Error fetching data: $e'};
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ride Details',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: rideDetails == null
          ? Center(child: CircularProgressIndicator())
          : rideDetails!.containsKey('error')
          ? Center(child: Text(rideDetails!['error']))
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (rideDetails!['start'] != null)
                Text(
                  'Start: ${rideDetails!['start']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              if (rideDetails!['destination'] != null)
                Text(
                  'End: ${rideDetails!['destination']}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              SizedBox(height: 20),
              if (rideDetails!['driver'] != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Driver: ${rideDetails!['driver']['name']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Phone: ${rideDetails!['driver']['phone']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Vehicle: ${rideDetails!['driver']['car_no']} (${rideDetails!['driver']['car_model']})',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              SizedBox(height: 20),
              Text(
                'Trip Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (rideDetails!['date'] != null)
                Text('Date: ${rideDetails!['date']}', style: TextStyle(fontSize: 18)),
              if (rideDetails!['time'] != null)
                Text('Time: ${rideDetails!['time']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text(
                'Passengers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (rideDetails!['people'] != null)
                ...rideDetails!['people'].map<Widget>((passenger) {
                  return ListTile(
                    title: Text(passenger['name'] ?? ''),
                    subtitle: Text(passenger['phone'] ?? ''),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(passenger['photoURL'] ?? ''),
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
