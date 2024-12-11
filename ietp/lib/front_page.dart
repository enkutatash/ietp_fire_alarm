import 'package:flutter/material.dart';
import 'package:ietp/firebase_operation.dart';
import 'package:ietp/home_page.dart';
import 'package:ietp/widget/button.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IETP'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButtons(
                text: "Get Started",
                onPressed: () {
                  saveToken();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                color: Colors.green,
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
