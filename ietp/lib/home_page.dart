import 'package:flutter/material.dart';
import 'package:ietp/firebase_operation.dart';
import 'package:ietp/front_page.dart';
import 'package:ietp/main.dart';
import 'package:ietp/widget/button.dart';
import 'package:just_audio/just_audio.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                text: "Stop",
                onPressed: () {
                  deleteToken();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => FrontPage()));
                },
                color: Colors.green,
                textColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
