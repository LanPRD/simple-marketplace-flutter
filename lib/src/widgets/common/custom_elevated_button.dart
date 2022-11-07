import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Function() onPressed;
  final Color? primaryColor;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.primaryColor,
    this.isLoading = false,
  }) : super(key: key);

  static const double height = 48;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: height / 2,
                width: height / 2,
                child: CircularProgressIndicator(strokeWidth: 3),
              )
            : Text(
                text,
                style: const TextStyle(fontSize: 16),
              ),
      ),
    );
  }
}
