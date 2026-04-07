import 'package:flutter/material.dart';
import 'package:saidco/ui/app/common/tile_layout.dart';

class FormListTile extends StatelessWidget {
  const FormListTile({
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

  Widget singleCell({required String text, required double width}) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: isHeader
            ? const TextStyle(fontWeight: FontWeight.w800)
            : const TextStyle(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white12, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            TileLayout(
              name: name,
              phoneNumber: phoneNumber,
              programLevel: programLevel,
              travelDate: travelDate,
              dayCount: dayCount,
              roomType: roomType,
            ),
          ],
        ),
      ),
    );
  }
}
