import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';
import 'package:saidco/features/possible_clients/domain/repositories/possible_clients_repo.dart';

class AddPossibleClients {
  AddPossibleClients(this.repository);

  final PossibleClientsRepo repository;

  Future<void> call(PossibleClient possibleClient) async {
    await repository.addPossibleClient(possibleClient);
  }
}
