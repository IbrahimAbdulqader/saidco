import 'package:cloud_firestore/cloud_firestore.dart';

class FormResponse {
  final String formId;
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
  final Timestamp submissionDate;
  final bool isContacted;

  FormResponse({
    required this.formId,
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
    required this.submissionDate,
    required this.isContacted,
  });

  factory FormResponse.fromJson(Map<String, dynamic> jsonData) {
    return FormResponse(
      formId: jsonData['responseId'] ?? 'Form ID not found',
      name: jsonData['اسم العميل'] ?? 'اسم العميل غير موجود',
      phoneNumber: jsonData['رقم هاتف العميل'] ?? 'ررقم الهاتف غير موجود',
      programLevel:
          jsonData['حدد مستوى البرنامج'] ?? 'مستوى البرنامج غير موجود',
      expectedCost:
          jsonData['حدد السعر المتوقع للبرنامج'] ?? 'السعر المتوقع غير موجود',
      travelDate: jsonData['حدد فترة الحجز'] == null
          ? 'تاريخ السفر غير موجود'
          : jsonData['حدد فترة الحجز'].toString(),
      dayCount:
          jsonData['حدد عدد أيام الرحلة المناسبة'] ?? 'عدد الأيام غير موجود',
      roomType:
          jsonData['حدد نوع غرف الفنادق المناسبة'] ?? 'نوع الغرفة غير موجود',
      hotelPreferences:
          jsonData['(اختياري) هل لديك تفضيلات من حيث الفنادق السكنية ؟'] ??
          'تفضيلات الفنادق غير موجودة',
      flightPreferences:
          jsonData['(اختياري) هل لديك تفضيلات من حيث شركة الطيران ؟'] ??
          'تفضيلات الطيران غير موجودة',
      additionalInfo:
          jsonData['(اختياري) هل لديك أي ملاحظات اخرى ؟'] ??
          'الملاحظات غير موجودة',
      submissionDate: jsonData['submissionDate'] ?? Timestamp.now(),
      isContacted: jsonData['isContacted'] ?? false,
    );
  }
}
