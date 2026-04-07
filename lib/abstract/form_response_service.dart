import 'package:saidco/models/form_response/form_response.dart';

abstract class FormResponseService {
  Stream<List<FormResponse>> getFormResponse();
}
