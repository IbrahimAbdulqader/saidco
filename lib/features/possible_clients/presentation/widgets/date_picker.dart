import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged, // We need this to pass the date back up!
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    String getWeekdayName(int weekday) {
      switch (weekday) {
        case 1:
          return 'الإتنين';
        case 2:
          return 'الثلاثاء';
        case 3:
          return 'الأربعاء';
        case 4:
          return 'الخميس';
        case 5:
          return 'الجمعة';
        case 6:
          return 'السبت';
        case 7:
          return 'الأحد';
        default:
          return '';
      }
    }

    return Column(
      children: [
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تاريخ السفر',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 1.5, color: Colors.grey[400]!),
          ),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SizedBox(
                      height: 450,
                      width: 550,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SfDateRangePicker(
                          initialSelectedDate: selectedDate,
                          selectionMode: DateRangePickerSelectionMode.single,
                          showActionButtons: true,
                          onSubmit: (Object? value) {
                            if (value is DateTime) {
                              onDateChanged(value);
                            }
                            Navigator.pop(context);
                          },
                          onCancel: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              title: Text(
                selectedDate == null
                    ? 'اختر تاريخ السفر'
                    : ' ${selectedDate!.day} / ${selectedDate!.month} / ${selectedDate!.year} - ${getWeekdayName(selectedDate!.weekday)}',
                style: selectedDate == null
                    ? Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.grey[600])
                    : Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: Icon(Icons.calendar_month, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }
}
