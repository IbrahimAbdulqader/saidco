import 'package:saidco/features/travels/domain/entities/travels.dart';
import 'package:saidco/features/travels/domain/repositories/travels_repo.dart';

class GetTravels {
  GetTravels(this.repository);

  final TravelsRepo repository;

  Stream<List<Travels>> call() {
    return repository.getTravels();
  }
}
