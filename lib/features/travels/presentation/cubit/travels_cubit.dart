import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/features/travels/domain/entities/travels.dart';
import 'package:saidco/features/travels/domain/usecases/add_travel.dart';
import 'package:saidco/features/travels/domain/usecases/delete_travel.dart';
import 'package:saidco/features/travels/domain/usecases/get_travels.dart';
import 'package:saidco/features/travels/domain/usecases/update_travel.dart';
import 'package:saidco/features/travels/presentation/cubit/travels_states.dart';

class TravelsCubit extends Cubit<TravelsState> {
  final AddTravel _addTravel;
  final GetTravels _getTravels;
  final UpdateTravel _updateTravel;
  final DeleteTravel _deleteTravel;

  StreamSubscription? _streamSubscription;

  TravelsCubit({
    required AddTravel addTravel,
    required GetTravels getTravels,
    required UpdateTravel updateTravel,
    required DeleteTravel deleteTravel,
  }) : _addTravel = addTravel,
       _getTravels = getTravels,
       _updateTravel = updateTravel,
       _deleteTravel = deleteTravel,
       super(TravelsLoading());

  Future<void> addTravel(Travels travel) async {
    try {
      await _addTravel(travel);
    } catch (e) {
      emit(TravelsError(e.toString()));
    }
  }

  void getTravels() {
    emit(TravelsLoading());

    _streamSubscription?.cancel();

    try {
      _streamSubscription = _getTravels().listen(
        (travels) {
          emit(TravelsLoaded(travels));
        },
        onError: (e) {
          emit(TravelsError(e.toString()));
        },
      );
    } catch (e) {
      emit(TravelsError(e.toString()));
    }
  }

  Future<void> updateTravel(Travels travel) async {
    try {
      await _updateTravel(travel);
    } catch (e) {
      emit(TravelsError(e.toString()));
    }
  }

  Future<void> deleteTravel(String travelId) async {
    try {
      await _deleteTravel(travelId);
    } catch (e) {
      emit(TravelsError(e.toString()));
    }
  }
}
