import 'package:flutter/material.dart';

class CustomOutlinedButtonWithIcon extends StatelessWidget {
  final String textButton;
  final dynamic icon;
  final VoidCallback onPressed;

  const CustomOutlinedButtonWithIcon({
    Key? key,
    required this.textButton,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            width: 1,
            color: Colors.green,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        icon: icon,
        onPressed: onPressed,
        label: Text(
          textButton,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
