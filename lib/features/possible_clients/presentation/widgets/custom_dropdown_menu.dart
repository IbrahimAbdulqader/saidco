import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.dropdownMenuEntries,
    required this.label,
    required this.errorMessage,
    required this.controller,
    required this.onSelected,
  });

  final String label;
  final List<DropdownMenuEntry> dropdownMenuEntries;
  final String? errorMessage;
  final TextEditingController controller;
  final ValueChanged<dynamic>? onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8),
        DropdownMenu(
          width: 510,
          errorText: errorMessage,
          controller: controller,
          onSelected: onSelected,
          inputDecorationTheme: InputDecorationTheme(
            constraints: BoxConstraints(
              minHeight: 40,
              maxHeight: errorMessage != null ? 60 : 40,
            ),
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
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          dropdownMenuEntries: dropdownMenuEntries,
        ),
      ],
    );
  }
}
