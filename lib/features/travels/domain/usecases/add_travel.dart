import 'package:saidco/features/travels/domain/entities/travels.dart';
import 'package:saidco/features/travels/domain/repositories/travels_repo.dart';

class AddTravel {
  AddTravel(this.repository);

  final TravelsRepo repository;

  Future<void> call(Travels travel) async {
    await repository.addTravel(travel);
  }
}
