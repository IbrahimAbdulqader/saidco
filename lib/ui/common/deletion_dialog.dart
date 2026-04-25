import 'package:flutter/material.dart';
import 'package:saidco/ui/common/custom_button.dart';

class DeletionDialog extends StatelessWidget {
  const DeletionDialog({
    super.key,
    required this.alertMessage,
    required this.content,
    required this.onDelete,
  });

  final String alertMessage;
  final String content;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 200,
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  alertMessage,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              Text(content),
              const Spacer(),
              Row(
                children: [
                  CustomButton(
                    width: 130,
                    text: 'إغلاق',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  CustomButton(
                    width: 140,
                    text: 'تأكيد الحذف',
                    backgroundColor: Colors.redAccent.withValues(alpha: 0.35),
                    foregroundColor: Colors.red[700],
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
