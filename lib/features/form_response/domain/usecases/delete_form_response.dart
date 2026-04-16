import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';

class DeleteFormResponse {
  DeleteFormResponse(this.repository);

  final FormResponseRepo repository;

  Future<void> call(String responseId) async {
    return await repository.deleteFormResponse(responseId);
  }
}
