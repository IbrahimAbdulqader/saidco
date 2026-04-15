import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/features/form_response/domain/entities/form_response.dart';

class FormResponseModel extends FormResponse {
  const FormResponseModel({
    required super.formId,
    required super.name,
    required super.phoneNumber,
    required super.programLevel,
    required super.expectedCost,
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
