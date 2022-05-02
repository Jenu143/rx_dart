import 'dart:io';
import 'dart:math';

import 'package:fire_auth_with_rx_dart/auth/auth.dart';
import 'package:fire_auth_with_rx_dart/model/custom_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

class AuthBlock {
  final AuthClass _authClass = AuthClass();
  // final OtherClass _otherClass = OtherClass();

  final streamController = PublishSubject();

  Stream get authStream => streamController.stream;

  Future logInSink({required String email, required String password}) async {
    final response = _authClass.logIn(email: email, password: password);
    streamController.sink.add(response);
    return response;
  }

  Future<CustomModel> registerSink({required String email, required String password}) async {
    final response = _authClass.register(email: email, password: password);
    streamController.sink.add(response);
    return response;
  }

  // Future otherSink({source, imageFile, pickedFile}) async {
  //   final response = _otherClass.pickImage(
  //     source: source,
  //     imageFile: imageFile,
  //     pickedFile: pickedFile,
  //   );
  //   streamController.sink.add(response);
  //   return response;
  // }

  Future logOutSink() async {
    final response = _authClass.logOut();
    streamController.sink.add(response);
    return response;
  }
}

class OtherClass {
  final ImagePicker _picker = ImagePicker();

  Future pickImage({
    required ImageSource source,
    XFile? pickedFile,
    File? imageFile,
  }) async {
    pickedFile = await _picker.pickImage(source: source);

    print(" Image : ${pickedFile?.path} ");

    imageFile = File(pickedFile!.path);
  }
}
