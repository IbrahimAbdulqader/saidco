import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';
import 'package:saidco/features/possible_clients/domain/usecases/add_possible_client.dart';
import 'package:saidco/features/possible_clients/domain/usecases/delete_possible_client.dart';
import 'package:saidco/features/possible_clients/domain/usecases/get_possible_clients.dart';
import 'package:saidco/features/possible_clients/domain/usecases/update_possible_client.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_states.dart';

class PossibleClientsCubit extends Cubit<PossibleClientsState> {
  final AddPossibleClients _addPossibleClients;
  final GetPossibleClients _getPossibleClients;
  final UpdatePossibleClient _updatePossibleClient;
  final DeletePossibleClient _deletePossibleClient;

  StreamSubscription? _streamSubscription;

  PossibleClientsCubit({
    required AddPossibleClients addPossibleClients,
    required GetPossibleClients getPossibleClients,
    required UpdatePossibleClient updatePossibleClient,
    required DeletePossibleClient deletePossibleClient,
  }) : _addPossibleClients = addPossibleClients,
       _getPossibleClients = getPossibleClients,
       _updatePossibleClient = updatePossibleClient,
       _deletePossibleClient = deletePossibleClient,
       super(PossibleClientsLoading());

  Future<void> addPossibleClients(PossibleClient possibleClient) async {
    try {
      await _addPossibleClients(possibleClient);
    } catch (e) {
      emit(PossibleClientsError(e.toString()));
    }
  }

  void getPossibleClients() {
    emit(PossibleClientsLoading());
    
    _streamSubscription?.cancel();

    try {
      _streamSubscription = _getPossibleClients().listen(
        (possibleClients) {
          emit(PossibleClientsLoaded(possibleClients));
        },
        onError: (e) {
          emit(PossibleClientsError(e.toString()));
        },
      );
    } catch (e) {
      emit(PossibleClientsError(e.toString()));
    }
  }

  Future<void> updatePossibleClient(PossibleClient possibleClient) async {
    try {
      await _updatePossibleClient(possibleClient);
    } catch (e) {
      emit(PossibleClientsError(e.toString()));
    }
  }

  Future<void> deletePossibleClient(String clientId) async {
    try {
      await _deletePossibleClient(clientId);
    } catch (e) {
      emit(PossibleClientsError(e.toString()));
    }
  }
}
