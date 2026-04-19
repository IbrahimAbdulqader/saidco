import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';

class ToggleContactStatus {
  ToggleContactStatus(this.repository);

  final FormResponseRepo repository;

  Future<void> call(String responseId, bool newStatus) {
    return repository.toggleContactStatus(responseId, newStatus);
  }
}
