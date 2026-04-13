import 'package:saidco/features/form_response/domain/entities/form_response.dart';
import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';

class RestoreFormResponse {
  RestoreFormResponse(this.repository);

  FormResponseRepository repository;

  Future<void> call(FormResponse response) async {
    return await repository.restoreFormResponse(response);
  }
}
