import 'package:saidco/features/travels/domain/entities/travels.dart';

class TravelsModel extends Travels {
  const TravelsModel({
    required super.travelId,
    required super.travelDate,
    required super.makkaDayCount,
    required super.madinaDayCount,
    required super.makkaRooms,
    required super.madinaRooms,
    required super.cost,
  });

  factory TravelsModel.fromJson(Map<String, dynamic> jsonData) {
    return TravelsModel(
      travelId: jsonData['travelId'] ?? 'Travel ID not found',
      travelDate: jsonData['travelDate'] ?? DateTime.now(),
      makkaDayCount:
          jsonData['makkaDayCount'] ?? 'أيام السكن في مكة غير موجودة',
      madinaDayCount:
          jsonData['madinaDayCount'] ?? 'أيام السكن في المدينة غير موجودة',
      makkaRooms: jsonData['makkaRooms'] ?? ['غرف السكن في مكة غير موجودة'],
      madinaRooms:
          jsonData['madinaRooms'] ?? ['غرف السكن في المدينة غير موجودة'],
      cost: jsonData['cost'] ?? 'تكلفة الرحلة غير موجودة',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'travelId': travelId,
      'travelDate': travelDate,
      'makkaDayCount': makkaDayCount,
      'madinaDayCount': madinaDayCount,
      'makkaRooms': makkaRooms,
      'madinaRooms': madinaRooms,
      'cost': cost,
    };
  }
}
