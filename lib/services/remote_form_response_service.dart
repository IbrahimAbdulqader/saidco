import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/abstract/form_response_service.dart';
import 'package:saidco/models/form_response/form_response.dart';

class RemoteFormResponseService extends FormResponseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<FormResponse>> getFormResponse() {
    try {
      return _firestore.collection('form_submissions').snapshots().map((
        snapshot,
      ) {
        return snapshot.docs.map((doc) {
          return FormResponse.fromJson(doc.data());
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to fetch form response: $e');
    }
  }
}
