import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/core/errors/exceptions.dart';
import 'package:saidco/features/possible_clients/data/models/possible_clients_model.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

abstract class PossibleClientsRemoteDatasource {
  Future<void> addPossibleClient(PossibleClient possibleClient);
  Stream<List<PossibleClientModel>> getPossibleClients();
  Future<void> updatePossibleClient(PossibleClient possibleClient);
  Future<void> deletePossibleClient(String clientId);
}

class PossibleClientsRemoteDatasourceImpl
    implements PossibleClientsRemoteDatasource {
  PossibleClientsRemoteDatasourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<void> addPossibleClient(PossibleClient possibleClient) async {
    final model = PossibleClientModel(
      clientId: possibleClient.clientId,
      name: possibleClient.name,
      phoneNumber: possibleClient.phoneNumber,
      programLevel: possibleClient.programLevel,
      expectedCost: possibleClient.expectedCost,
      travelDate: possibleClient.travelDate,
      dayCount: possibleClient.dayCount,
      roomType: possibleClient.roomType,
      hotelPreferences: possibleClient.hotelPreferences,
      flightPreferences: possibleClient.flightPreferences,
      additionalInfo: possibleClient.additionalInfo,
      submissionDate: possibleClient.submissionDate,
    );

    try {
      await _firestore
          .collection('possible_clients')
          .doc(model.clientId)
          .set(model.toJson());
    } on FirebaseException catch (e) {
      throw Exception('Failed to add possible client: ${e.message}');
    } catch (e) {
      throw Exception(
        'An unexpected error occurred during possible client addition',
      );
    }
  }

  @override
  Stream<List<PossibleClientModel>> getPossibleClients() {
    return _firestore
        .collection('possible_clients')
        .orderBy('submissionDate', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return PossibleClientModel.fromJson(doc.data());
          }).toList();
        })
        .handleError((e) {
          ServerException('Failed to fetch possible clients: $e');
        });
  }

  @override
  Future<void> updatePossibleClient(PossibleClient possibleClient) async {
    final model = PossibleClientModel(
      clientId: possibleClient.clientId,
      name: possibleClient.name,
      phoneNumber: possibleClient.phoneNumber,
      programLevel: possibleClient.programLevel,
      expectedCost: possibleClient.expectedCost,
      travelDate: possibleClient.travelDate,
      dayCount: possibleClient.dayCount,
      roomType: possibleClient.roomType,
      hotelPreferences: possibleClient.hotelPreferences,
      flightPreferences: possibleClient.flightPreferences,
      additionalInfo: possibleClient.additionalInfo,
      submissionDate: possibleClient.submissionDate,
    );

    final data = model.toJson();

    await _firestore
        .collection('possible_clients')
        .doc(possibleClient.clientId)
        .update(data);
  }

  @override
  Future<void> deletePossibleClient(String clientId) async {
    try {
      await _firestore.collection('possible_clients').doc(clientId).delete();
    } on FirebaseException catch (e) {
      throw ServerException('Failed to delete possible client: ${e.message}');
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred during possible client deletion',
      );
    }
  }
}
