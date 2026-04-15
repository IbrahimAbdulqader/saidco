import 'package:equatable/equatable.dart';
import 'package:saidco/features/form_response/domain/entities/form_response.dart';

abstract class FormResponseState extends Equatable {
  const FormResponseState();

  @override
  List<Object> get props => [];
}

class FormResponseLoading extends FormResponseState {}

class FormResponseLoaded extends FormResponseState {
  final List<FormResponse> responses;

  const FormResponseLoaded(this.responses);

  @override
  List<Object> get props => [responses];
}

class FormResponseError extends FormResponseState {
  final String message;

  const FormResponseError(this.message);

  @override
  List<Object> get props => [message];
}
