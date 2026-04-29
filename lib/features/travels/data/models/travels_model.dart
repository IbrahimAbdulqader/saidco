import 'package:saidco/features/travels/domain/entities/travels.dart';

class TravelsModel extends Travels {
  const TravelsModel({
    required super.travelDate,
    required super.makkaDayCount,
    required super.madinaDayCount,
    required super.makkaRooms,
    required super.madinaRooms,
    required super.cost,
  });

  factory TravelsModel.fromJson(Map<String, dynamic> jsonData) {
    return TravelsModel(
      travelDate: jsonData['travelDate'] ?? DateTime.now(),
      makkaDayCount: jsonData['makkaDayCount'] ?? '',
      madinaDayCount: jsonData['madinaDayCount'] ?? '',
      makkaRooms: jsonData['makkaRooms'] ?? [],
      madinaRooms: jsonData['madinaRooms'] ?? [],
      cost: jsonData['cost'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'travelDate': travelDate,
      'makkaDayCount': makkaDayCount,
      'madinaDayCount': madinaDayCount,
      'makkaRooms': makkaRooms,
      'madinaRooms': madinaRooms,
      'cost': cost,
    };
  }
}
