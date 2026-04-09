import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text = 'رجوع',
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor:
              backgroundColor ??
              Colors.deepPurpleAccent[100]!.withValues(alpha: 0.35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: foregroundColor ?? Colors.deepPurpleAccent[500],
          ),
        ),
      ),
    );
  }
}
