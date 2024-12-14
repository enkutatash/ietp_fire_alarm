import 'package:flutter/material.dart';
import 'package:ietp/firebase_operation.dart';
import 'package:ietp/home_page.dart';
import 'package:ietp/widget/button.dart';

class FrontPage extends StatelessWidget {
  FrontPage({super.key});

  final TextEditingController nameController = TextEditingController();

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButtons(
              text: "Get Started",
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isEmpty) {
                  // Show an error if the name field is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Name is required!')),
                  );
                } else {
                  // Pass the name to saveToken and navigate
                  saveToken(name);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }
              },
              color: Colors.green,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
