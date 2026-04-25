import 'package:flutter/material.dart';

class FilterToggleButtons extends StatefulWidget {
  const FilterToggleButtons({
    super.key,
    required this.onPressed,
    required this.isSelected,
  });

  final Function(int) onPressed;
  final List<bool> isSelected;

  @override
  State<FilterToggleButtons> createState() => _FilterToggleButtonsState();
}

class _FilterToggleButtonsState extends State<FilterToggleButtons> {
  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      constraints: const BoxConstraints(maxHeight: 35, minHeight: 35),
      borderRadius: BorderRadius.circular(12),
      borderWidth: 2,
      borderColor: Colors.grey[500],
      selectedBorderColor: Colors.deepPurpleAccent[700]!.withValues(alpha: 0.8),
      selectedColor: Colors.deepPurpleAccent[700]!.withValues(alpha: 0.8),
      fillColor: Colors.deepPurpleAccent[700]!.withValues(alpha: 0.2),
      textStyle: TextStyle(
        color: Colors.grey[500],
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      onPressed: widget.onPressed,
      isSelected: widget.isSelected,
      children: const [
        SizedBox(width: 120, child: Center(child: Text('الكل'))),
        SizedBox(width: 120, child: Center(child: Text('لم يتم التواصل'))),
      ],
    );
  }
}
