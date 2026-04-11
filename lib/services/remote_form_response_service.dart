import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/abstract/form_response_service.dart';
import 'package:saidco/models/form_response/form_response.dart';

class RemoteFormResponseService extends FormResponseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<FormResponse>> getFormResponse(String? filterStatus) {
    try {
      Query firestoreQuery = _firestore.collection('form_submissions');

      if (filterStatus == 'notContacted') {
        firestoreQuery = firestoreQuery.where('isContacted', isEqualTo: false);
      } else if (filterStatus == 'isContacted') {
        firestoreQuery = firestoreQuery.where('isContacted', isEqualTo: true);
      }

      return firestoreQuery.snapshots().map((snapshot) {
        List<FormResponse> responses = snapshot.docs.map((doc) {
          return FormResponse.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        responses.sort((a, b) => b.submissionDate.compareTo(a.submissionDate));

        return responses;
      });
    } catch (e) {
      throw Exception('Failed to fetch form response: $e');
    }
  }
}
