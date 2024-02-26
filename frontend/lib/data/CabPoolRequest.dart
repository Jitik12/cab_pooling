import 'package:flutter/material.dart';
import 'package:swift_street/enums/num_people.dart';
import 'package:swift_street/enums/time_slot.dart';

class CabPoolRequest {
  TimeSlot timeSlot = TimeSlot.hour_1;
  NumPeople numpeople = NumPeople.one;
  NumPeople num1 = NumPeople.one;
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  String start = "";
  String destination = "";

  CabPoolRequest({
    this.timeSlot = TimeSlot.hour_1,
    this.numpeople = NumPeople.one,
    this.num1 = NumPeople.one,
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
}
