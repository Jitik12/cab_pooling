import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as devtools;
import 'package:http/http.dart' as http;
import 'package:swift_street/data/BackendUser.dart';
import 'package:swift_street/data/CabPoolRequest.dart';


class BackendService {
  String backendUrl = 'https://dhruvin-cabs.jitik.online:8000';

  static final BackendService _shared = BackendService._sharedInstance();
  BackendService._sharedInstance();
  factory BackendService() => _shared;

  Future<void> registerUser(GoogleSignInAccount user) async
  {
    // Register user with backend
    try{

      BackendUser backendUser = BackendUser.fromGoogleSignInAccount(user);
      final response = await http.post(Uri.parse('$backendUrl/register'), body: backendUser.toJson());

      if(response.statusCode != 200)
      {
        throw Exception('Failed to register user');
      }

    } catch (error) {
      devtools.log(error.toString(), name: 'BackendService');
    } 
  }

  Future<void> fetchRideInfo(CabPoolRequest request) async
  {
    // Fetch ride info from backend
    try{
     await  http.post(Uri.parse('$backendUrl/fetchRideInfo'), body: request.toJsonForRegister());
    } catch (error) {
      devtools.log(error.toString(), name: 'BackendService');
    }
  }

}
