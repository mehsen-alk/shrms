import 'package:flutter/material.dart';
import 'package:shrms/views/components/box_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SHRMS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Box(text: "Employees", onPress: () {}),
            Box(text: "Weeks", onPress: () {}),
          ],
        ),
      ),
    );
  }
}
