import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

abstract class PossibleClientsRepo {
  Future<void> addPossibleClient(PossibleClients possibleClient);

  Stream<List<PossibleClients>> getPossibleClients();

  Future<void> updatePossibleClient(PossibleClients possibleClient);

  Future<void> deletePossibleClient(String clientId);
}
