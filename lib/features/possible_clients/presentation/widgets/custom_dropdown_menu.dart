import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({
    super.key,
    required this.dropdownMenuEntries,
    required this.label,
  });

  final String label;
  final List<DropdownMenuEntry> dropdownMenuEntries;

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        DropdownMenu(
          width: 510,
          inputDecorationTheme: InputDecorationTheme(
            constraints: BoxConstraints(maxHeight: 40),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.deepPurple[200]!,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          dropdownMenuEntries: widget.dropdownMenuEntries,
        ),
      ],
    );
  }
}
