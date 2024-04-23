import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as devtools;

import 'package:swift_street/constants/secrets.dart';

class AuthService /*implements AuthProviderClass*/ {
  static final AuthService _shared = AuthService._sharedInstance();
  AuthService._sharedInstance();
  factory AuthService() => _shared;
  // final AuthProviderClass provider  ;

  // factory AuthService.google() {
  //   return AuthService(provider: GoogleAuthClass());
  // }

  // AuthService({required this.provider});
  // @override
  // AuthUser? get currentUser => provider.currentUser;

  // @override
  // Future<void> initialize()async {
  //   await provider.initialize();
  // }

  // @override
  // Future<AuthUser> signIn() async{
  //   return await provider.signIn();
  // }

  // @override
  // Future<void> signOut() async{
  //   await provider.signOut();
  // }
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId: CLIENT_ID,
    scopes: ['email'],
  );

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Future<void> signInWithGoogle() async {

      if (currentUser != null) {
        return;
      }

      await _googleSignIn.signIn();

   
  }

  Future<void> signOutGoogle() async {
    try {
      if (currentUser != null) {
        await _googleSignIn.signOut();
      }
    } catch (error) {
      devtools.log(error.toString(), name: 'AuthService');
    }
  }

  Future<void> refreshToken() async {
    try {
      await _googleSignIn.signInSilently();
    } catch (error) {
      devtools.log(error.toString(), name: 'AuthService');
    }
  }

  Future<void> silentSignIn() async {
    try {
      await _googleSignIn.signInSilently();
    } catch (error) {
      devtools.log(error.toString(), name: 'AuthService');
    }
  }
}
