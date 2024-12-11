import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final String text;
  bool isLoading;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  CustomButtons({
    required this.text,
    this.isLoading = false,
    required this.onPressed,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                text,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w800),
              ),
      ),
    );
  }
}
