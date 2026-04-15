import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/features/form_response/domain/entities/form_response.dart';

class FormResponseModel extends FormResponse {
  const FormResponseModel({
    required super.formId,
    required super.name,
    required super.phoneNumber,
    required super.programLevel,
    required super.travelDate,
    required super.dayCount,
    required super.roomType,
    required super.hotelPreferences,
    required super.flightPreferences,
    required super.additionalInfo,
    required super.submissionDate,
    required super.isContacted,
  });

  factory FormResponseModel.fromJson(Map<String, dynamic> jsonData) {
    return FormResponseModel(
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

  Map<String, dynamic> toJson() {
    return {
      'responseId': formId,
      'اسم العميل': name,
      'رقم هاتف العميل': phoneNumber,
      'حدد مستوى البرنامج': programLevel,
      'حدد فترة الحجز': travelDate,
      'حدد عدد أيام الرحلة المناسبة': dayCount,
      'حدد نوع غرف الفنادق المناسبة': roomType,
      '(اختياري) هل لديك تفضيلات من حيث الفنادق السكنية ؟': hotelPreferences,
      '(اختياري) هل لديك تفضيلات من حيث شركة الطيران ؟': flightPreferences,
      '(اختياري) هل لديك أي ملاحظات اخرى ؟': additionalInfo,
      'submissionDate': submissionDate,
      'isContacted': isContacted,
    };
  }
}
