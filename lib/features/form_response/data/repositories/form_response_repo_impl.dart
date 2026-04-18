import 'package:saidco/features/form_response/data/datasources/form_remote_datasource.dart';
import 'package:saidco/features/form_response/domain/entities/form_response.dart';
import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

class FormResponseRepoImpl implements FormResponseRepo {
  FormResponseRepoImpl(this._remoteDataSource);

  final FormRemoteDataSource _remoteDataSource;

  @override
  Stream<List<FormResponse>> getFormResponse(String? filterStatus) {
    return _remoteDataSource.getFormResponses(filterStatus);
  }

  @override
  Future<void> transferToPossibleClient(PossibleClient possibleClient) {
    return _remoteDataSource.transferToPossibleClient(possibleClient);
  }

  @override
  Future<void> deleteFormResponse(String responseId) {
    return _remoteDataSource.deleteFormResponse(responseId);
  }
}
