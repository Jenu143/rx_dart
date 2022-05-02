import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth_with_rx_dart/constant/circuler_dialog.dart';
import 'package:fire_auth_with_rx_dart/constant/error_dialogs.dart';
import 'package:fire_auth_with_rx_dart/view/Register/register_screen.dart';
import 'package:fire_auth_with_rx_dart/components/default_button.dart';
import 'package:fire_auth_with_rx_dart/components/text_auth_field.dart';
import 'package:fire_auth_with_rx_dart/block/auth_block.dart';
import 'package:fire_auth_with_rx_dart/constant/colors.dart';
import 'package:fire_auth_with_rx_dart/constant/strings.dart';
import 'package:fire_auth_with_rx_dart/home_Screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final AuthBlock _authBlock = AuthBlock();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                //& log in text
                Text(
                  Strings.logIn,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: ColorName.greyColor.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: 20),

                //& email
                email(),

                const SizedBox(height: 30),

                //& password
                password(),
                const SizedBox(height: 30),

                //& login button
                loginButton(context),
                const SizedBox(height: 30),

                //&text button
                createAccountTextBtn(context),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //^ create accout text button
  Widget createAccountTextBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          ),
        );
      },
      child: Text(
        Strings.createAccount,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  //^ login button
  Widget loginButton(BuildContext context) {
    return DefaultButton(
      name: Strings.logIn,
      press: () async {
        if (_formKey.currentState!.validate()) {
          circulerDialog(context: context);
          final res = await _authBlock.logInSink(
            email: emailController.text,
            password: passController.text,
          );

          if (res == null) {
            Navigator.of(context).pop();

            return commanDialog(
                context: context,
                error: "Do register first or check your password...");
          } else {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(resUid: res.uid),
              ),
            );
          }
        }
      },
    );
  }

  //^ password
  Widget password() {
    return TextFieldAuth(
      controller: passController,
      hintText: Strings.password,
      validator: (value) {
        RegExp regex = RegExp(Strings.passwordPettern);
        if (value!.isEmpty) {
          return Strings.passEmptyError;
        } else if (value.length < 8) {
          return Strings.passLengthError;
        } else if (!regex.hasMatch(value)) {
          return Strings.passWeekError;
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
