import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';
import 'package:saidco/features/possible_clients/domain/repositories/possible_clients_repo.dart';

class GetPossibleClients {
  GetPossibleClients(this.repository);

  final PossibleClientsRepo repository;

  Stream<List<PossibleClient>> call() {
    return repository.getPossibleClients();
  }
}
