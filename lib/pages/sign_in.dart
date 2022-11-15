// ignore_for_file: sort_child_properties_last

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firabase/pages/home_page.dart';
import 'package:firabase/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySignIn extends StatefulWidget {
  const MySignIn({super.key});

  @override
  State<MySignIn> createState() => _MySignInState();
}

class _MySignInState extends State<MySignIn> {
  bool select = false;

  final _emailCntr = TextEditingController();
  final _passwordCntr = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    _emailCntr.text = prefs.getString("email") ?? "";
    _passwordCntr.text = prefs.getString("password") ?? "";
  }

  Future<bool> SaveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("email", _emailCntr.text);
    prefs.setString("password", _passwordCntr.text);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textFromField("Email", false, _emailCntr),
              _textFromField("Password", true, _passwordCntr),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await _awesimoDialog(true);
                },
                child: const Text("Sign In"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 87, 32),
                  fixedSize: const Size(double.maxFinite, 46),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {
                      _awesimoDialog(false);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 87, 32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textFromField(String s, bool icons, TextEditingController controller) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        obscureText: icons ? !select : false,
        validator: (value) {
          if (!icons) {
            if (value?.isNotEmpty == true) {
              if (value?.contains("@") == false) {
                return "Error";
              }
            }
          } else {
            if (value?.isNotEmpty == true) {
              if (value![0].codeUnits[0] >= 65 && value[0].codeUnits[0] <= 90) {
              } else {
                return "Error: 'A....Z'";
              }
            }
          }
        },
        decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: s,
          suffixIcon: icons
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      select = !select;
                    });
                  },
                  icon: Icon(
                    select ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
        ),
      ),
    );
  }

  _awesimoDialog(bool navigator) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      transitionAnimationDuration: const Duration(milliseconds: 600),
      title: 'Save',
      desc: 'Email, Password,',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnCancelOnPress: () {
        navigator
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MySignUp(),
                ),
              );
      },
      btnOkOnPress: () {
        SaveLogin();
        navigator
            ? Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              )
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MySignUp(),
                ),
              );
      },
    ).show();
  }
}
