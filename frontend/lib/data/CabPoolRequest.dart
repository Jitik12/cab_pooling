import 'package:CabX/enums/num_people.dart';
import 'package:CabX/enums/time_slot.dart';
import 'package:CabX/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CabPoolRequest {
  int timeSlot = 0;
  NumPeople numpeople = NumPeople.one; // min people
  NumPeople num1 = NumPeople.one; // max people
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  // String date_string = "";
  // String time_string = "";
  String start = "";
  String destination = "";

  CabPoolRequest({
    this.numpeople = NumPeople.one,
    // required this.date,
    // required this.time,
    // required this.start,
    // required this.destination
  });

  CabPoolRequest.fromJson(Map<String, dynamic> json) {
    timeSlot = json['timeSlot'];
    numpeople = json['numpeople'];
    num1 = json['num1'];
    time = json['time'];
    date = json['date'];
    start = json['start'];
    destination = json['destination'];
  }

  Map<String, dynamic> toJsonForRegister() {
    String formattedTime = '${time.hour}:${time.minute} ${time.period.index == 0 ? 'AM' : 'PM'}';
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    return {
      "email": AuthService().currentUser!.email,
      "timeslot": timeSlot,
      "zone": "RGAI",
      "numpeople": int.parse(numpeople.value),
      "min": int.parse(numpeople.value),
      "max": 4,
      "time": formattedTime,
      "date": formattedDate,
      "start": start,
      "destination": destination,
    };
  }
}
