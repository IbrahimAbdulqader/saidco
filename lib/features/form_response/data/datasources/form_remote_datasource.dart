import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/core/errors/exceptions.dart';
import 'package:saidco/features/form_response/data/models/form_response_model.dart';
import 'package:saidco/features/possible_clients/data/models/possible_clients_model.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

abstract class FormRemoteRemoteDatasource {
  Stream<List<FormResponseModel>> getFormResponses(String? filterStatus);
  Future<void> transferToPossibleClient(PossibleClient possibleClient);
  Future<void> deleteFormResponse(String responseId);
  Future<void> toggleContactStatus(String responseId, bool newStatus);
}

class FormRemoteDataSourceImpl implements FormRemoteRemoteDatasource {
  FormRemoteDataSourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<List<FormResponseModel>> getFormResponses(String? filterStatus) {
    Query firestoreQuery = _firestore.collection('form_submissions');

    if (filterStatus == 'notContacted') {
      firestoreQuery = firestoreQuery.where('isContacted', isEqualTo: false);
    } else if (filterStatus == 'isContacted') {
      firestoreQuery = firestoreQuery.where('isContacted', isEqualTo: true);
    }

    return firestoreQuery
        .snapshots()
        .map((snapshot) {
          List<FormResponseModel> responses = snapshot.docs.map((doc) {
            return FormResponseModel.fromJson(
              doc.data() as Map<String, dynamic>,
            );
          }).toList();

          responses.sort(
            (a, b) => b.submissionDate.compareTo(a.submissionDate),
          );
          return responses;
        })
        .handleError((error) {
          throw ServerException('Failed to fetch form responses: $error');
        });
  }

  @override
  Future<void> transferToPossibleClient(PossibleClient possibleClient) async {
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
      submissionDate: Timestamp.now(),
    );
    final data = model.toJson();
    try {
      await _firestore
          .collection('possible_clients')
          .doc(possibleClient.clientId)
          .set(data);
      await deleteFormResponse(possibleClient.clientId);
    } on FirebaseException catch (e) {
      throw ServerException('Failed to transfer form response: ${e.message}');
    } catch (e) {
      ServerException(
        'An unexpected error occurred during form response transfer',
      );
    }
  }

  @override
  Future<void> deleteFormResponse(String responseId) async {
    try {
      await _firestore.collection('form_submissions').doc(responseId).delete();
    } on FirebaseException catch (e) {
      throw ServerException('Failed to delete form response: ${e.message}');
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred during form response deletion',
      );
    }
  }

  @override
  Future<void> toggleContactStatus(String responseId, bool newStatus) async {
    try {
      await _firestore.collection('form_submissions').doc(responseId).update({
        'isContacted': newStatus,
      });
    } on FirebaseException catch (e) {
      throw ServerException('Failed to toggle contact status: ${e.message}');
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred during contact status toggle',
      );
    }
  }
}
