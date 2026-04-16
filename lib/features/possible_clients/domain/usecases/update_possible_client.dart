import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';
import 'package:saidco/features/possible_clients/domain/repositories/possible_clients_repo.dart';

class UpdatePossibleClient {
  UpdatePossibleClient(this.repository);

  final PossibleClientsRepo repository;

  Future<void> call(PossibleClients possibleClient) async {
    await repository.updatePossibleClient(possibleClient);
  }
}
