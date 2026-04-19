import 'package:saidco/features/form_response/domain/entities/form_response.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

abstract class FormResponseRepo {
  Stream<List<FormResponse>> getFormResponse(String? filterStatus);

  Future<void> transferToPossibleClient(PossibleClient possibleClient);

  Future<void> deleteFormResponse(String responseId);

  Future<void> toggleContactStatus(String responseId, bool newStatus);
}
