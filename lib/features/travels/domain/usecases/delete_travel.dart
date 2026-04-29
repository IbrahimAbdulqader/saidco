import 'package:saidco/features/travels/domain/repositories/travels_repo.dart';

class DeleteTravel {
  DeleteTravel(this.repository);

  final TravelsRepo repository;

  Future<void> call(String travelId) async {
    await repository.deleteTravel(travelId);
  }
}
