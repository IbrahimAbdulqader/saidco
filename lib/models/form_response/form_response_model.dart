import 'package:cloud_firestore/cloud_firestore.dart';

class FormResponse {
  final String formId;
  final String name;
  final String phoneNumber;
  final String programLevel;
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
      name: jsonData['اسم العميل'] ?? 'Name not found',
      phoneNumber: jsonData['رقم هاتف العميل'] ?? 'Phone number not found',
      programLevel: jsonData['حدد مستوى البرنامج'] ?? 'Program level not found',
      travelDate: jsonData['حدد فترة الحجز'] == null
          ? 'Travel date not found'
          : jsonData['حدد فترة الحجز'].toString(),
      dayCount:
          jsonData['حدد عدد أيام الرحلة المناسبة'] ?? 'Day count not found',
      roomType:
          jsonData['حدد نوع غرف الفنادق المناسبة'] ?? 'Room type not found',
      hotelPreferences:
          jsonData['(اختياري) هل لديك تفضيلات من حيث الفنادق السكنية ؟'] ??
          'Hotel preferences not found',
      flightPreferences:
          jsonData['(اختياري) هل لديك تفضيلات من حيث شركة الطيران ؟'] ??
          'Flight preferences not found',
      additionalInfo:
          jsonData['(اختياري) هل لديك أي ملاحظات اخرى ؟'] ??
          'Additional info not found',
      submissionDate: jsonData['submissionDate'] ?? Timestamp.now(),
      isContacted: jsonData['isContacted'] ?? false,
    );
  }
}
