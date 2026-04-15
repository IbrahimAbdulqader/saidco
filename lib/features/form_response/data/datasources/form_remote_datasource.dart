import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/core/errors/exceptions.dart';
import 'package:saidco/features/form_response/data/models/form_response_model.dart';

abstract class FormRemoteDataSource {
  Stream<List<FormResponseModel>> getFormResponses(String? filterStatus);
  Future<void> deleteFormResponse(String formId);
}

class FormRemoteDataSourceImpl implements FormRemoteDataSource {
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
              //   doc.id
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
  Future<void> deleteFormResponse(String formId) async {
    try {
      await _firestore.collection('form_submissions').doc(formId).delete();
    } on FirebaseException catch (e) {
      throw ServerException('Failed to delete form response: ${e.message}');
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred during form response deletion',
      );
    }
  }
}
