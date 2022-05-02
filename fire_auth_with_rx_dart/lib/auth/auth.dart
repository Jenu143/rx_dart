import 'package:fire_auth_with_rx_dart/constant/strings.dart';
import 'package:fire_auth_with_rx_dart/model/custom_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //* Log in
  Future<User?> logIn({required String email, required String password}) async {
    try {
      final loginResponse = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return loginResponse.user;
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

  //* Sing in
  Future<CustomModel> register(
      {required String email, required String password}) async {
    try {
      final registerResponse = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return CustomModel(user: registerResponse.user);
    } on FirebaseAuthException catch (e) {
      return CustomModel(msg: e.message);
    }
  }

  //* log out
  Future logOut() async {
    await _auth.signOut();

    print(Strings.logOut);
  }
}
