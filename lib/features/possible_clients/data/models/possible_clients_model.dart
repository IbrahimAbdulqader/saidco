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
    return PossibleClientModel(
      clientId: jsonData['clientId'] ?? 'Client ID not found',
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
      'submission_date': submissionDate,
    };
  }
}
