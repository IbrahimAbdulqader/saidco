import 'package:equatable/equatable.dart';

class Travels extends Equatable {
  const Travels({
    required this.travelDate,
    required this.makkaDayCount,
    required this.madinaDayCount,
    required this.makkaRooms,
    required this.madinaRooms,
    required this.cost,
  });

  final DateTime travelDate;
  final String makkaDayCount;
  final String madinaDayCount;
  final List<String> makkaRooms;
  final List<String> madinaRooms;
  final String cost;

  @override
  List<Object?> get props => [];
}
