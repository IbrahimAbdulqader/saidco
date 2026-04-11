import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.text = 'رجوع',
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
  });
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 165,
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
        ).copyWith(elevation: WidgetStateProperty.all(0)),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: foregroundColor ?? Colors.deepPurpleAccent[500],
          ),
        ),
      ),
    );
  }
}
