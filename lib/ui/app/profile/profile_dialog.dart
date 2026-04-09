import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saidco/models/form_response/form_response.dart';
import 'package:saidco/ui/common/custom_button.dart';
import 'package:saidco/ui/common/custom_rich_text.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key, required this.formResponse});

  final FormResponse formResponse;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.grey[100],
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 800,
          minWidth: 600,
          maxWidth: 600,
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
                      CustomRichText(
                        title: 'الاسم',
                        subtitle: formResponse.name,
                      ),
                      Spacer(),
                      Text(
                        formResponse.isContacted
                            ? 'تم التواصل'
                            : 'لم يتم التواصل',
                        style: TextStyle(
                          fontSize: 14,
                          color: formResponse.isContacted
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                  CustomRichText(
                    title: 'رقم الهاتف',
                    subtitle: formResponse.phoneNumber,
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
                        CustomRichText(
                          title: 'المستوى',
                          subtitle: formResponse.programLevel,
                        ),
                        CustomRichText(
                          title: 'تاريخ السفر',
                          subtitle: formResponse.travelDate,
                        ),
                        CustomRichText(
                          title: 'عدد الأيام',
                          subtitle: formResponse.dayCount.toString(),
                        ),
                        CustomRichText(
                          title: 'نوع الغرفة',
                          subtitle: formResponse.roomType,
                        ),
                        CustomRichText(
                          title: 'ملاحظات الفنادق السكنية',
                          subtitle: formResponse.hotelPreferences == ''
                              ? 'لا يوجد'
                              : formResponse.hotelPreferences,
                        ),
                        CustomRichText(
                          title: 'ملاحظات شركة الطيران',
                          subtitle: formResponse.flightPreferences == ''
                              ? 'لا يوجد'
                              : formResponse.flightPreferences,
                        ),
                        CustomRichText(
                          title: 'الملاحظات الاضافية',
                          subtitle: formResponse.additionalInfo == ''
                              ? 'لا يوجد'
                              : formResponse.additionalInfo,
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
                  Spacer(),
                  CustomButton(
                    text: !formResponse.isContacted
                        ? 'تم التواصل'
                        : 'لم يتم التواصل',
                    backgroundColor: !formResponse.isContacted
                        ? Colors.greenAccent.withValues(alpha: 0.35)
                        : Colors.redAccent.withValues(alpha: 0.35),
                    foregroundColor: !formResponse.isContacted
                        ? Colors.lightGreen[700]
                        : Colors.red[700],
                    onPressed: () {
                      firestore
                          .collection('form_submissions')
                          .doc(formResponse.formId)
                          .update({'isContacted': !formResponse.isContacted});
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
