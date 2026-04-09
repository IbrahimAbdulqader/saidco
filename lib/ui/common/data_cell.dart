import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  const TextCell({
    super.key,
    required this.text,
    required this.flex,
    this.isBold = false,
    this.color,
  });

  final String text;
  final int flex;
  final bool isBold;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontSize: 15,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
