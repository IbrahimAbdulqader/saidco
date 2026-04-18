import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

class TransferFormResponse {
  TransferFormResponse(this.repository);

  final FormResponseRepo repository;

  Future<void> call(PossibleClient possibleClient) async {
    return await repository.transferToPossibleClient(possibleClient);
  }
}
