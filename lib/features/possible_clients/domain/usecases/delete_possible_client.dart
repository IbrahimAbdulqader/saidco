import 'package:saidco/features/possible_clients/domain/repositories/possible_clients_repo.dart';

class DeletePossibleClient {
  DeletePossibleClient(this.repository);

  final PossibleClientsRepo repository;

  Future<void> call(String clientId) async {
    await repository.deletePossibleClient(clientId);
  }
}
