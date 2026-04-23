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
    required super.hotelPreferences,
    required super.flightPreferences,
    required super.additionalInfo,
    required super.submissionDate,
  });

  factory PossibleClientModel.fromJson(Map<String, dynamic> jsonData) {
    final firebaseSubmissionDate = jsonData['submissionDate'] as Timestamp?;

    return PossibleClientModel(
      clientId: jsonData['clientId'] ?? 'Client ID not found',
      name: jsonData['client_name'] ?? 'اسم العميل غير موجود',
      phoneNumber: jsonData['client_phone'] ?? 'رقم الهاتف غير موجود',
      programLevel: jsonData['program_level'] ?? 'مستوى البرنامج غير موجود',
      expectedCost: jsonData['expected_cost'] ?? 'السعر المتوقع غير موجود',
      travelDate: jsonData['travel_date'] ?? 'تاريخ السفر غير موجود',
      dayCount: jsonData['day_count'] ?? 'عدد الأيام غير موجود',
      roomType: jsonData['room_type'] ?? 'نوع الغرفة غير موجود',
      hotelPreferences:
          jsonData['hotel_preferences'] ?? 'تفضيلات الفنادق غير موجودة',
      flightPreferences:
          jsonData['flight_preferences'] ?? 'تفضيلات الطيران غير موجودة',
      additionalInfo: jsonData['additional_info'] ?? 'الملاحظات غير موجودة',
      submissionDate: firebaseSubmissionDate != null
          ? firebaseSubmissionDate.toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'client_name': name,
      'client_phone': phoneNumber,
      'program_level': programLevel,
      'expected_cost': expectedCost,
      'travel_date': travelDate,
      'day_count': dayCount,
      'room_type': roomType,
      'hotel_preferences': hotelPreferences,
      'flight_preferences': flightPreferences,
      'additional_info': additionalInfo,
      'submission_date': FieldValue.serverTimestamp(),
    };
  }
}
