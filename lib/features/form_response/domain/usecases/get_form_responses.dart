import 'package:saidco/features/form_response/domain/entities/form_response.dart';
import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';

class GetFormResponses {
  GetFormResponses(this.repository);

  final FormResponseRepo repository;

  Stream<List<FormResponse>> call(String? filterStatus) {
    return repository.getFormResponse(filterStatus);
  }
}
