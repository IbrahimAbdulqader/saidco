import 'package:saidco/features/travels/domain/entities/travels.dart';

abstract class TravelsRepo {
  Future<void> addTravel(Travels travel);

  Stream<List<Travels>> getTravels();

  Future<void> updateTravel(Travels travel);

  Future<void> deleteTravel(String travelId);
}
