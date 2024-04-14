import 'package:google_sign_in/google_sign_in.dart';
import 'package:swift_street/constants/secrets.dart';
import 'package:swift_street/services/auth/auth_provider.dart';
import 'package:swift_street/services/auth/auth_user.dart';
import 'package:swift_street/services/auth/google_auth_provider.dart';
import 'dart:developer' as devtools;

class AuthService /*implements AuthProviderClass*/ {
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
      devtools.log('User already signed in ${currentUser}',
          name: 'AuthService');
      return;
    }
    await _googleSignIn.signIn();
    devtools.log('User signed in ${currentUser}', name: 'AuthService');
    GoogleSignInAuthentication? authentication =
        await currentUser?.authentication;

    devtools.log(
        'Authentication token ${authentication?.idToken} ${authentication?.accessToken}',
        name: 'AuthService');
  }

  Future<void> signOutGoogle() async {
    try {
      devtools.log('User signed out ${currentUser}', name: 'AuthService');
      await _googleSignIn.signOut();
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
}
