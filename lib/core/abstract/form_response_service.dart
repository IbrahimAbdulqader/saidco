import 'package:saidco/models/form_response/form_response_model.dart';

abstract class FormResponseService {
  Stream<List<FormResponse>> getFormResponse(String? filterStatus);
}
