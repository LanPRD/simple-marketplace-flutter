import 'package:flutter/material.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  final String text;
  final dynamic icon;
  final VoidCallback onPressed;

  const CustomElevatedButtonWithIcon({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onPressed,
        label: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        icon: icon is IconData
            ? Icon(
                icon,
                color: Colors.white,
              )
            : icon,
      ),
    );
  }
}
