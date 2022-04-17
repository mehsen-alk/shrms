import 'package:flutter/material.dart';
import 'package:shrms/components/box_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("SHrms"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 250),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Box(text: "Employee", onPress: () {}),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Box(text: "Edit Employee", onPress: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
