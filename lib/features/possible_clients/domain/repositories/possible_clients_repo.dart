import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

abstract class PossibleClientsRepo {
  Future<void> addPossibleClient(PossibleClient possibleClient);

  Stream<List<PossibleClient>> getPossibleClients();

  Future<void> updatePossibleClient(PossibleClient possibleClient);

  Future<void> deletePossibleClient(String clientId);
}
