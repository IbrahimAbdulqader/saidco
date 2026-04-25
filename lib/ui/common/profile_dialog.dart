import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saidco/core/utils/date_helper.dart';
import 'package:saidco/ui/common/custom_button.dart';
import 'package:saidco/ui/common/custom_rich_text.dart';
import 'package:saidco/core/utils/custom_toast.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({
    super.key,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.programLevel,
    required this.expectedCost,
    required this.travelDate,
    required this.dayCount,
    required this.roomType,
    required this.hotelPreferences,
    required this.flightPreferences,
    required this.additionalInfo,
    this.isContacted,
    this.toggleContacted,
  });

  final String id;
  final String name;
  final String phoneNumber;
  final String programLevel;
  final String expectedCost;
  final String travelDate;
  final String dayCount;
  final String roomType;
  final String hotelPreferences;
  final String flightPreferences;
  final String additionalInfo;

  final bool? isContacted;
  final VoidCallback? toggleContacted;

  @override
  Widget build(BuildContext context) {
    String formatDate(String dateString) {
      DateTime date = DateTime.parse(dateString);
      return DateHelper.formatDate(date);
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.grey[100],
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 900,
          minWidth: 1100,
          maxWidth: 1100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Info
              Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomRichText(title: 'الاسم', subtitle: name),
                      const Spacer(),
                      if (isContacted != null)
                        Text(
                          isContacted! ? 'تم التواصل' : 'لم يتم التواصل',
                          style: TextStyle(
                            fontSize: 14,
                            color: isContacted! ? Colors.green : Colors.red,
                          ),
                        ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomRichText(
                        title: 'رقم الهاتف',
                        subtitle: phoneNumber,
                      ),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: phoneNumber));

                            showCustomToast(context, 'تم النسخ بنجاح');
                          },
                          icon: const Icon(Icons.copy, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 40, thickness: 1),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      spacing: 20,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 550,
                              child: CustomRichText(
                                title: 'المستوى',
                                subtitle: programLevel,
                              ),
                            ),
                            CustomRichText(
                              title: 'السعر المتوقع',
                              subtitle: expectedCost.trim() == ''
                                  ? 'لا يوجد'
                                  : expectedCost,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            SizedBox(
                              width: 550,
                              child: CustomRichText(
                                title: 'نوع الغرفة',
                                subtitle: roomType,
                              ),
                            ),
                            CustomRichText(
                              title: 'عدد الأيام',
                              subtitle: dayCount.toString(),
                            ),
                          ],
                        ),
                        CustomRichText(
                          title: 'تاريخ السفر',
                          subtitle: formatDate(travelDate),
                        ),

                        CustomRichText(
                          title: 'ملاحظات الفنادق السكنية',
                          subtitle: hotelPreferences.trim() == ''
                              ? 'لا يوجد'
                              : hotelPreferences,
                        ),
                        CustomRichText(
                          title: 'ملاحظات شركة الطيران',
                          subtitle: flightPreferences.trim() == ''
                              ? 'لا يوجد'
                              : flightPreferences,
                        ),
                        CustomRichText(
                          title: 'الملاحظات الاضافية',
                          subtitle: additionalInfo.trim() == ''
                              ? 'لا يوجد'
                              : additionalInfo,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Action Button
              Row(
                children: [
                  CustomButton(
                    text: 'إغلاق',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  if (isContacted != null && toggleContacted != null)
                    CustomButton(
                      text: !isContacted! ? 'تم التواصل' : 'لم يتم التواصل',
                      backgroundColor: !isContacted!
                          ? Colors.greenAccent.withValues(alpha: 0.35)
                          : Colors.redAccent.withValues(alpha: 0.35),
                      foregroundColor: !isContacted!
                          ? Colors.lightGreen[700]
                          : Colors.red[700],
                      onPressed: () {
                        toggleContacted!();
                        Navigator.pop(context);
                      },
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
