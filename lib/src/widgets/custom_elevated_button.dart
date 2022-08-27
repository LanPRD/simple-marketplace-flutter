import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? primaryColor;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
