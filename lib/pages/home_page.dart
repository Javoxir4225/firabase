import 'package:firabase/pages/sign_in.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 87, 32),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.sort,
          ),
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.black,
        width: 240,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const MySignIn(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 87, 32),
            fixedSize: const Size(160, 46),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
