import 'package:saidco/features/possible_clients/data/datasources/possible_clients_remote_datasource.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';
import 'package:saidco/features/possible_clients/domain/repositories/possible_clients_repo.dart';

class PossibleClientsRepoImpl implements PossibleClientsRepo {
  PossibleClientsRepoImpl(this._remoteDatasource);

  final PossibleClientsRemoteDatasource _remoteDatasource;

  @override
  Future<void> addPossibleClient(PossibleClient possibleClient) {
    return _remoteDatasource.addPossibleClient(possibleClient);
  }

  @override
  Stream<List<PossibleClient>> getPossibleClients() {
    return _remoteDatasource.getPossibleClients();
  }

  @override
  Future<void> updatePossibleClient(PossibleClient possibleClient) {
    return _remoteDatasource.updatePossibleClient(possibleClient);
  }

  @override
  Future<void> deletePossibleClient(String clientId) {
    return _remoteDatasource.deletePossibleClient(clientId);
  }
}
