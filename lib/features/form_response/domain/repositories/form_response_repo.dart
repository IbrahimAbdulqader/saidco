import 'package:saidco/features/form_response/domain/entities/form_response.dart';

abstract class FormResponseRepository {
  Stream<List<FormResponse>> getFormResponse(String? filterStatus);

  Future<void> deleteFormResponse(String formId);

  Future<void> restoreFormResponse(FormResponse response);
}
