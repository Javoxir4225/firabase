// ignore_for_file: sort_child_properties_last

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firabase/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySignUp extends StatefulWidget {
  const MySignUp({super.key});

  @override
  State<MySignUp> createState() => _MySignUpState();
}

class _MySignUpState extends State<MySignUp> {
  bool select = false;

  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passworController = TextEditingController();

  @override
  void initState() {
    getName();
    super.initState();
  }

  void getName() async {
    final pref = await SharedPreferences.getInstance();
    _fullnameController.text = pref.getString("fullName") ?? "";
    _emailController.text = pref.getString("Email") ?? "";
    _passworController.text = pref.getString("Password") ?? "";
  }

  Future<bool> SaveName() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("fullName", _fullnameController.text);
    pref.setString("Email", _emailController.text);
    pref.setString("Password", _passworController.text);
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
              _textField("Fullname", false, false, _fullnameController),
              _textField("Email", false, true, _emailController),
              _textField("Password", true, false, _passworController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await _aweSimoDialog(true);
                },
                child: const Text("Sign Up"),
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
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {
                      _aweSimoDialog(false);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text(
                      "Sign In",
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

  _textField(
      String s, bool icons, bool validaTor, TextEditingController controller) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        controller: controller,
        autocorrect: false,
        obscureText: icons ? !select : false,
        validator: (value) {
          if (validaTor) {
            if (value?.isNotEmpty == true) {
              if (value?.contains("@") == false) {
                return "Error: '@'";
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

  _aweSimoDialog(bool naVigator) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      transitionAnimationDuration: const Duration(milliseconds: 600),
      title: 'Save',
      desc: 'Fullname,Email, Password,',
      buttonsTextStyle: const TextStyle(color: Colors.black),
      showCloseIcon: true,
      btnCancelOnPress: () {
        naVigator
            ? null
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
      },
      btnOkOnPress: () {
        SaveName();
        naVigator
            ? null
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
              );
      },
    ).show();
  }
}
