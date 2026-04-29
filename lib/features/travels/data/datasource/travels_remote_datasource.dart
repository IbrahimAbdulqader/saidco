import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saidco/core/errors/exceptions.dart';
import 'package:saidco/features/travels/data/models/travels_model.dart';
import 'package:saidco/features/travels/domain/entities/travels.dart';

abstract class TravelsRemoteDatasource {
  Future<void> addTravel(Travels travel);
  Stream<List<Travels>> getTravels();
  Future<void> updateTravel(Travels travel);
  Future<void> deleteTravel(String travelId);
}

class TravelsRemoteDatasourceImpl implements TravelsRemoteDatasource {
  TravelsRemoteDatasourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<void> addTravel(Travels travel) async {
    final model = TravelsModel(
      travelId: travel.travelId,
      travelDate: travel.travelDate,
      makkaDayCount: travel.makkaDayCount,
      madinaDayCount: travel.madinaDayCount,
      makkaRooms: travel.makkaRooms,
      madinaRooms: travel.madinaRooms,
      cost: travel.cost,
    );

    try {
      await _firestore
          .collection('travels')
          .doc(model.travelId)
          .set(model.toJson());
    } on FirebaseException catch (e) {
      throw ServerException('Failed to add travel: ${e.message}');
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred during travel addition',
      );
    }
  }

  @override
  Stream<List<Travels>> getTravels() {
    return _firestore
        .collection('travels')
        .orderBy('submissionDate')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return TravelsModel.fromJson(doc.data());
          }).toList();
        })
        .handleError((e) {
          ServerException('Failed to fetch travels: $e');
        });
  }

  @override
  Future<void> updateTravel(Travels travel) async {
    final model = TravelsModel(
      travelId: travel.travelId,
      travelDate: travel.travelDate,
      makkaDayCount: travel.makkaDayCount,
      madinaDayCount: travel.madinaDayCount,
      makkaRooms: travel.makkaRooms,
      madinaRooms: travel.madinaRooms,
      cost: travel.cost,
    );

    final data = model.toJson();

    try {
      await _firestore.collection('travels').doc(model.travelId).update(data);
    } on FirebaseException catch (e) {
      throw ServerException('Failed to update travel: ${e.message}');
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred during travel update',
      );
    }
  }

  @override
  Future<void> deleteTravel(String travelId) async {
    try {
      await _firestore.collection('travels').doc(travelId).delete();
    } on FirebaseException catch (e) {
      throw ServerException('Failed to delete travel: ${e.message}');
    } catch (e) {
      throw ServerException(
        'An unexpected error occurred during travel deletion',
      );
    }
  }
}
