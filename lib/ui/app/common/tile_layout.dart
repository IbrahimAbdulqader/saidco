import 'package:flutter/material.dart';

class TileLayout extends StatelessWidget {
  const TileLayout({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.programLevel,
    required this.travelDate,
    required this.dayCount,
    required this.roomType,
    this.isHeader = false,
  });
  final String name;
  final String phoneNumber;
  final String programLevel;
  final String travelDate;
  final String dayCount;
  final String roomType;
  final bool isHeader;

  Widget buildCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: isHeader
            ? const TextStyle(fontWeight: FontWeight.bold)
            : const TextStyle(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildCell(name, 180),
        const SizedBox(width: 16),
        buildCell(phoneNumber, 140),
        const SizedBox(width: 16),
        buildCell(programLevel, 140),
        const SizedBox(width: 16),
        buildCell(travelDate, 120),
        const SizedBox(width: 16),
        buildCell(dayCount, 100),
        const SizedBox(width: 16),
        buildCell(roomType, 140),
      ],
    );
  }
}
