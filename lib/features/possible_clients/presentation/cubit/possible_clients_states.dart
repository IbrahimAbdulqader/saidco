import 'package:equatable/equatable.dart';
import 'package:saidco/features/possible_clients/domain/entities/possible_clients.dart';

abstract class PossibleClientsState extends Equatable {
  const PossibleClientsState();

  @override
  List<Object> get props => [];
}

class PossibleClientsLoading extends PossibleClientsState {}

class PossibleClientsLoaded extends PossibleClientsState {
  const PossibleClientsLoaded(this.possibleClients);

  final List<PossibleClient> possibleClients;

  @override
  List<Object> get props => [possibleClients];
}

class PossibleClientsError extends PossibleClientsState {
  final String message;

  const PossibleClientsError(this.message);

  @override
  List<Object> get props => [message];
}
