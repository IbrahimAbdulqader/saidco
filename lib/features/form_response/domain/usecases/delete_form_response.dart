import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';

class DeleteFormResponse {
  DeleteFormResponse(this.repository);

  final FormResponseRepo repository;

  Future<void> call(String formId) async {
    return await repository.deleteFormResponse(formId);
  }
}
