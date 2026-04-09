import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  const TextCell({
    super.key,
    required this.text,
    required this.flex,
    this.isBold = false,
  });

  final String text;
  final int flex;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 15,
          fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
