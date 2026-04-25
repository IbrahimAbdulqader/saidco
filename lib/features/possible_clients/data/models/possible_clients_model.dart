import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

class PossibleClientModel extends PossibleClient {
  const PossibleClientModel({
    required super.clientId,
    required super.name,
    required super.phoneNumber,
    required super.programLevel,
    required super.expectedCost,
    required super.travelDate,
    required super.dayCount,
    required super.roomType,
    required super.familyInfo,
    required super.hotelPreferences,
    required super.flightPreferences,
    required super.additionalInfo,
    required super.submissionDate,
  });

  factory PossibleClientModel.fromJson(Map<String, dynamic> jsonData) {
    final firebaseSubmissionDate = jsonData['submissionDate'] as Timestamp?;

    return PossibleClientModel(
      clientId: jsonData['clientId'] ?? 'Client ID not found',
      name: jsonData['clientName'] ?? 'اسم العميل غير موجود',
      phoneNumber: jsonData['clientPhone'] ?? 'رقم الهاتف غير موجود',
      programLevel: jsonData['programLevel'] ?? 'مستوى البرنامج غير موجود',
      expectedCost: jsonData['expectedCost'] ?? 'السعر المتوقع غير موجود',
      travelDate: jsonData['travelDate'] ?? 'تاريخ السفر غير موجود',
      dayCount: jsonData['dayCount'] ?? 'عدد الأيام غير موجود',
      roomType: jsonData['roomType'] ?? 'نوع الغرفة غير موجود',
      familyInfo: jsonData['familyInfo'] ?? 'معلومات العائلة غير موجودة',
      hotelPreferences:
          jsonData['hotelPreferences'] ?? 'تفضيلات الفنادق غير موجودة',
      flightPreferences:
          jsonData['flightPreferences'] ?? 'تفضيلات الطيران غير موجودة',
      additionalInfo: jsonData['additionalInfo'] ?? 'الملاحظات غير موجودة',
      submissionDate: firebaseSubmissionDate != null
          ? firebaseSubmissionDate.toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'clientName': name,
      'clientPhone': phoneNumber,
      'programLevel': programLevel,
      'expectedCost': expectedCost,
      'travelDate': travelDate,
      'dayCount': dayCount,
      'roomType': roomType,
      'familyInfo': familyInfo,
      'hotelPreferences': hotelPreferences,
      'flightPreferences': flightPreferences,
      'additionalInfo': additionalInfo,
      'submissionDate': FieldValue.serverTimestamp(),
    };
  }
}
