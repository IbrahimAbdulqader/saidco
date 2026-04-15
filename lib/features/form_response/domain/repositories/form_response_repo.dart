import 'package:saidco/features/form_response/domain/entities/form_response.dart';

abstract class FormResponseRepo {
  Stream<List<FormResponse>> getFormResponse(String? filterStatus);

  Future<void> deleteFormResponse(String formId);
}
