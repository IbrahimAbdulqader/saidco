import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/features/form_response/domain/entities/form_response.dart';
import 'package:saidco/features/form_response/domain/usecases/delete_form_response.dart';
import 'package:saidco/features/form_response/domain/usecases/get_form_responses.dart';
import 'package:saidco/features/form_response/domain/usecases/toggle_contact_status.dart';
import 'package:saidco/features/form_response/domain/usecases/transfer_form_response.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_state.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

class FormResponseCubit extends Cubit<FormResponseState> {
  final GetFormResponses _getFormResponses;
  final DeleteFormResponse _deleteFormResponse;
  final TransferFormResponse _transferFormResponse;
  final ToggleContactStatus _toggleContactStatus;

  StreamSubscription? _streamSubscription;

  FormResponseCubit({
    required GetFormResponses getFormResponses,
    required DeleteFormResponse deleteFormResponse,
    required TransferFormResponse transferFormResponse,
    required ToggleContactStatus toggleContactStatus,
  }) : _getFormResponses = getFormResponses,
       _deleteFormResponse = deleteFormResponse,
       _transferFormResponse = transferFormResponse,
       _toggleContactStatus = toggleContactStatus,
       super(FormResponseLoading());

  void getFormResponses({String? filterStatus}) {
    emit(FormResponseLoading());

    _streamSubscription?.cancel();

    try {
      _streamSubscription = _getFormResponses(filterStatus).listen(
        (responses) {
          emit(FormResponseLoaded(responses));
        },
        onError: (error) {
          emit(FormResponseError(error.toString()));
        },
      );
    } catch (e) {
      emit(FormResponseError(e.toString()));
    }
  }

  Future<void> transferToPossibleClient(FormResponse formResponse) async {
    try {
      final possibleClient = PossibleClient(
        clientId: formResponse.responseId,
        name: formResponse.name,
        phoneNumber: formResponse.phoneNumber,
        programLevel: formResponse.programLevel,
        expectedCost: formResponse.expectedCost,
        travelDate: formResponse.travelDate,
        dayCount: formResponse.dayCount,
        roomType: formResponse.roomType,
        hotelPreferences: formResponse.hotelPreferences,
        flightPreferences: formResponse.flightPreferences,
        additionalInfo: formResponse.additionalInfo,
        submissionDate: formResponse.submissionDate,
      );
      await _transferFormResponse(possibleClient);
    } catch (e) {
      emit(FormResponseError(e.toString()));
    }
  }

  Future<void> deleteFormResponse(String responseId) async {
    try {
      await _deleteFormResponse(responseId);
    } catch (e) {
      emit(FormResponseError(e.toString()));
    }
  }

  Future<void> toggleContactStatus(String responseId, bool newStatus) async {
    try {
      await _toggleContactStatus(responseId, newStatus);
    } catch (e) {
      emit(FormResponseError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
