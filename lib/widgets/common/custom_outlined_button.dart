import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String textButton;
  final VoidCallback onPressed;

  const CustomOutlinedButton({
    Key? key,
    required this.textButton,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            width: 1,
            color: Colors.green,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          textButton,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
