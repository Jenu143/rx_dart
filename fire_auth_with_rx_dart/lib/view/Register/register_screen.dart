import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth_with_rx_dart/components/default_button.dart';
import 'package:fire_auth_with_rx_dart/components/text_auth_field.dart';
import 'package:fire_auth_with_rx_dart/block/auth_block.dart';
import 'package:fire_auth_with_rx_dart/constant/circuler_dialog.dart';
import 'package:fire_auth_with_rx_dart/constant/colors.dart';
import 'package:fire_auth_with_rx_dart/constant/error_dialogs.dart';
import 'package:fire_auth_with_rx_dart/constant/strings.dart';
import 'package:fire_auth_with_rx_dart/home_Screen.dart';
import 'package:fire_auth_with_rx_dart/model/custom_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController conformpassController = TextEditingController();
  TextEditingController numController = TextEditingController();
  final AuthBlock authBlock = AuthBlock();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CustomModel customModel = CustomModel();

  //! image
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;

  // //* pick image
  Future pickImage({required ImageSource source}) async {
    pickedFile = await _picker.pickImage(source: source);

    print(" Image : ${pickedFile?.path} ");

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  //* upload image
  Future uploadImage() async {
    var storageimage = FirebaseStorage.instance.ref().child("/photo.jpg");
    UploadTask task1 = storageimage.putFile(_imageFile!);
    var imgUrl1 = await (await task1).ref.getDownloadURL();
    print(imgUrl1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  //& sing in text
                  Text(
                    Strings.singUp,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: ColorName.greyColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  //& image picker
                  imagePicker(context),
                  const SizedBox(height: 20),

                  //& email
                  email(),
                  const SizedBox(height: 30),

                  //& password
                  password(),
                  const SizedBox(height: 30),

                  //& conform password
                  conformPassword(),
                  const SizedBox(height: 30),

                  //& mobile number
                  mobileNumber(),
                  const SizedBox(height: 30),

                  //& register button
                  registerButton(context),
                  const SizedBox(height: 30),

                  haveAnAccountTextButton(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//^ image picker
  Widget imagePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => bottomModalSheets(context),
      child: _imageFile == null
          ? Container(
              height: 150,
              width: 150,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt_outlined),
            )
          : Container(
              height: 150,
              width: 150,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: ColorName.greyColor,
                shape: BoxShape.circle,
              ),
              child: Image.file(
                _imageFile!,
                fit: BoxFit.cover,
                width: 2000,
              ),
            ),
    );
  }

  //^ have an account text button
  Widget haveAnAccountTextButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Text(
        Strings.haveAnAccount,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  //^ register button
  Widget registerButton(BuildContext context) {
    return DefaultButton(
      name: Strings.create,
      press: () async {
        if (_formKey.currentState!.validate()) {
          circulerDialog(context: context);
          final CustomModel res = await authBlock.registerSink(
            email: emailController.text,
            password: passController.text,
          );

          if (res.user == null) {
            Navigator.of(context).pop();
            commanDialog(context: context, error: res.msg);
          } else if (_imageFile == null) {
            Navigator.of(context).pop();
            return commanDialog(context: context, error: "Image not found!");
          } else {
            await uploadImage();
            Navigator.of(context).pop();
            firestore.collection("collectionPath").doc(res.user!.uid).set({
              "email": res.user!.email,
              "name": "Jenis Radadiya",
              "num": "2165",
            });
            Navigator.of(context).pop();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(resUid: res.user!.uid),
              ),
            );
          }
        }
      },
    );
  }

//^ bottom model sheets
  Future<void> bottomModalSheets(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: ColorName.greyColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text(
                    Strings.camera,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // _authBlock.otherSink(
                    //   imageFile: _imageFile,
                    //   pickedFile: pickedFile,
                    //   source: ImageSource.gallery,
                    // );

                    pickImage(source: ImageSource.camera);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  child: Text(
                    Strings.gallery,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // _authBlock.otherSink(
                    //   imageFile: _imageFile,
                    //   pickedFile: pickedFile,
                    //   source: ImageSource.camera,
                    // );
                    pickImage(source: ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //^ cofrom password
  Widget conformPassword() {
    return TextFieldAuth(
      controller: conformpassController,
      hintText: "Conform Password",
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter conform password';
        } else if (passController.text != value) {
          return 'Password not match!';
        }
      },
      keyBoardType: TextInputType.visiblePassword,
    );
  }

  //^ mobile number
  Widget mobileNumber() {
    return TextFieldAuth(
      controller: numController,
      hintText: "Mobile Number",
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter phone number';
        } else if (value.length < 10) {
          return 'Enter Valid phoner number';
        } else if (value.length > 10) {
          return 'Enter Valid phoner number';
        }
        return null;
      },
      keyBoardType: TextInputType.number,
    );
  }

  //^ password
  Widget password() {
    return TextFieldAuth(
      controller: passController,
      hintText: "Password",
      validator: (value) {
        RegExp regex = RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
        if (value!.isEmpty) {
          return 'Please enter password';
        } else if (value.length < 8) {
          return 'Enter minimun 8 char';
        } else if (!regex.hasMatch(value)) {
          return 'Enter Strong password';
        }
      },
      keyBoardType: TextInputType.visiblePassword,
    );
  }

  //^ email
  Widget email() {
    return TextFieldAuth(
      controller: emailController,
      hintText: Strings.emailText,
      validator: (value) {
        String pattern = Strings.emailPettern;

        RegExp regex = RegExp(pattern);
        if (value!.isEmpty) {
          return Strings.emailEmptyError;
        } else if (!regex.hasMatch(value)) {
          return Strings.emailInvalidError;
        }
      },
      keyBoardType: TextInputType.emailAddress,
    );
  }
}
