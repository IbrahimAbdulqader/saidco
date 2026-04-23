import 'package:equatable/equatable.dart';

class PossibleClient extends Equatable {
  final String clientId;
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
  final DateTime submissionDate;

  const PossibleClient({
    required this.clientId,
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
  });

  @override
  List<Object?> get props => [
    clientId,
    name,
    phoneNumber,
    programLevel,
    expectedCost,
    travelDate,
    dayCount,
    roomType,
    hotelPreferences,
    flightPreferences,
    additionalInfo,
    submissionDate,
  ];
}
