import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saidco/features/form_response/domain/usecases/delete_form_response.dart';
import 'package:saidco/features/form_response/domain/usecases/get_form_responses.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_state.dart';

class FormResponseCubit extends Cubit<FormResponseState> {
  final GetFormResponses _getFormResponses;
  final DeleteFormResponse _deleteFormResponse;

  StreamSubscription? _formResponseSubscription;

  FormResponseCubit({
    required GetFormResponses getFormResponses,
    required DeleteFormResponse deleteFormResponse,
  }) : _getFormResponses = getFormResponses,
       _deleteFormResponse = deleteFormResponse,
       super(FormResponseLoading());

  void fetchFormResponses({String? filterStatus}) {
    emit(FormResponseLoading());

    _formResponseSubscription?.cancel();

    try {
      _formResponseSubscription = _getFormResponses(filterStatus).listen(
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

  Future<void> deleteFormResponse(String responseId) async {
    try {
      await _deleteFormResponse(responseId);
    } catch (e) {
      emit(FormResponseError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _formResponseSubscription?.cancel();
    return super.close();
  }
}
