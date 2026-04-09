import 'package:flutter/material.dart';
import 'package:saidco/models/form_response/form_response.dart';
import 'package:saidco/ui/common/layouts/main_layout.dart';
import 'package:saidco/ui/common/text_bubble.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.formResponse});

  final FormResponse formResponse;

  @override
  Widget build(context) {
    return MainLayout(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextBubble(text: 'الاسم:  ${formResponse.name}'),
                      SizedBox(width: 20),
                      TextBubble(
                        text: 'رقم الهاتف:  ${formResponse.phoneNumber}',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextBubble(text: 'المستوى:  ${formResponse.programLevel}'),
                  SizedBox(height: 20),
                  TextBubble(text: 'تاريخ السفر:  ${formResponse.travelDate}'),
                  SizedBox(height: 20),
                  TextBubble(text: 'عدد الأيام:  ${formResponse.dayCount}'),
                  SizedBox(height: 20),
                  TextBubble(text: 'نوع الغرفة:  ${formResponse.roomType}'),
                  SizedBox(height: 20),
                  TextBubble(
                    text:
                        'ملاحظات الفنادق السكنية:  ${formResponse.hotelPreferences == '' ? 'لا يوجد' : formResponse.hotelPreferences}',
                  ),
                  SizedBox(height: 20),
                  TextBubble(
                    text:
                        'ملاحظات شركة الطيران:  ${formResponse.flightPreferences == '' ? 'لا يوجد' : formResponse.flightPreferences}',
                  ),
                  SizedBox(height: 20),
                  TextBubble(
                    text:
                        'الملاحظات الاضافية:  ${formResponse.additionalInfo == '' ? 'لا يوجد' : formResponse.additionalInfo}',
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('رجوع'),
          ),
        ],
      ),
    );
  }
}
