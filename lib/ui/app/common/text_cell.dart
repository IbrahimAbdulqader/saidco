import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  const TextCell({super.key, required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
