import 'package:flutter/material.dart';

class HeaderCell extends StatelessWidget {
  final String text;
  final IconData? icon;
  final int flex;
  const HeaderCell({
    super.key,
    required this.text,
    required this.flex,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[700],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
