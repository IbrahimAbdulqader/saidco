import 'package:equatable/equatable.dart';
import 'package:saidco/features/travels/domain/entities/travels.dart';

abstract class TravelsState extends Equatable {
  const TravelsState();

  @override
  List<Object> get props => [];
}

class TravelsLoading extends TravelsState {}

class TravelsLoaded extends TravelsState {
  const TravelsLoaded(this.travels);

  final List<Travels> travels;

  @override
  List<Object> get props => [travels];
}

class TravelsError extends TravelsState {
  const TravelsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
