import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:saidco/features/form_response/data/datasources/form_remote_datasource.dart';
import 'package:saidco/features/form_response/data/repositories/form_response_repo_impl.dart';
import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';
import 'package:saidco/features/form_response/domain/usecases/delete_form_response.dart';
import 'package:saidco/features/form_response/domain/usecases/get_form_responses.dart';
import 'package:saidco/features/form_response/domain/usecases/toggle_contact_status.dart';
import 'package:saidco/features/form_response/domain/usecases/transfer_form_response.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_cubit.dart';
import 'package:saidco/features/possible_clients/data/datasources/possible_clients_remote_datasource.dart';
import 'package:saidco/features/possible_clients/data/repositories/possible_clients_repo_impl.dart';
import 'package:saidco/features/possible_clients/domain/repositories/possible_clients_repo.dart';
import 'package:saidco/features/possible_clients/domain/usecases/add_possible_client.dart';
import 'package:saidco/features/possible_clients/domain/usecases/delete_possible_client.dart';
import 'package:saidco/features/possible_clients/domain/usecases/get_possible_clients.dart';
import 'package:saidco/features/possible_clients/domain/usecases/update_possible_client.dart';
import 'package:saidco/features/possible_clients/presentation/cubit/possible_clients_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Feature - Form Response

  sl.registerFactory(
    () => FormResponseCubit(
      getFormResponses: sl(),
      deleteFormResponse: sl(),
      transferFormResponse: sl(),
      toggleContactStatus: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetFormResponses(sl()));
  sl.registerLazySingleton(() => DeleteFormResponse(sl()));
  sl.registerLazySingleton(() => TransferFormResponse(sl()));
  sl.registerLazySingleton(() => ToggleContactStatus(sl()));

  sl.registerLazySingleton<FormResponseRepo>(() => FormResponseRepoImpl(sl()));

  sl.registerLazySingleton<FormRemoteRemoteDatasource>(
    () => FormRemoteDataSourceImpl(firestore: sl()),
  );

  //Feature - Possible Clients

  sl.registerFactory(
    () => PossibleClientsCubit(
      addPossibleClients: sl(),
      getPossibleClients: sl(),
      updatePossibleClient: sl(),
      deletePossibleClient: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddPossibleClients(sl()));
  sl.registerLazySingleton(() => GetPossibleClients(sl()));
  sl.registerLazySingleton(() => UpdatePossibleClient(sl()));
  sl.registerLazySingleton(() => DeletePossibleClient(sl()));

  sl.registerLazySingleton<PossibleClientsRepo>(
    () => PossibleClientsRepoImpl(sl()),
  );

  sl.registerLazySingleton<PossibleClientsRemoteDatasource>(
    () => PossibleClientsRemoteDatasourceImpl(firestore: sl()),
  );

  //External Services

  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
