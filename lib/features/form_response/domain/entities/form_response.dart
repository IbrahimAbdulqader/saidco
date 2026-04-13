import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FormResponse extends Equatable {
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

  const FormResponse({
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

  @override
  List<Object?> get props => [
    formId,
    name,
    phoneNumber,
    programLevel,
    travelDate,
    dayCount,
    roomType,
    hotelPreferences,
    flightPreferences,
    additionalInfo,
    submissionDate,
    isContacted,
  ];
}
