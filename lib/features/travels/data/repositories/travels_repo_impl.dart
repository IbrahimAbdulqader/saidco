import 'package:saidco/features/travels/data/datasource/travels_remote_datasource.dart';
import 'package:saidco/features/travels/domain/entities/travels.dart';
import 'package:saidco/features/travels/domain/repositories/travels_repo.dart';

class TravelsRepoImpl implements TravelsRepo {
  TravelsRepoImpl(this._remoteDataSource);

  final TravelsRemoteDatasource _remoteDataSource;

  @override
  Future<void> addTravel(Travels travel) {
    return _remoteDataSource.addTravel(travel);
  }

  @override
  Stream<List<Travels>> getTravels() {
    return _remoteDataSource.getTravels();
  }

  @override
  Future<void> updateTravel(Travels travel) {
    return _remoteDataSource.updateTravel(travel);
  }

  @override
  Future<void> deleteTravel(String travelId) {
    return _remoteDataSource.deleteTravel(travelId);
  }
}
