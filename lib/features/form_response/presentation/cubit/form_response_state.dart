import 'package:equatable/equatable.dart';
import 'package:saidco/features/form_response/domain/entities/form_response.dart';

abstract class FormResponseState extends Equatable {
  const FormResponseState();

  @override
  List<Object> get props => [];
}

class FormResponseLoading extends FormResponseState {}

class FormResponseLoaded extends FormResponseState {
  const FormResponseLoaded(this.responses);

  final List<FormResponse> responses;

  @override
  List<Object> get props => [responses];
}

class FormResponseError extends FormResponseState {
  const FormResponseError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
