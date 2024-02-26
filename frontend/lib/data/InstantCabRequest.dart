import 'package:swift_street/enums/instant_time.dart';
import 'package:swift_street/enums/num_people.dart';

class InstantCabRequest {
  InstantTime instantTime = InstantTime.now;
  NumPeople numpeople = NumPeople.one;
  String start = "";
  String destination = "";

  InstantCabRequest();

  InstantCabRequest.fromJson(Map<String, dynamic> json) {
    instantTime = json['instantTime'];
    numpeople = json['numpeople'];
    start = json['start'];
    destination = json['destination'];
  }
}
