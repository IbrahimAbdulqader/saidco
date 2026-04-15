import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:saidco/features/form_response/data/datasources/form_remote_datasource.dart';
import 'package:saidco/features/form_response/data/repositories/form_response_repo_impl.dart';
import 'package:saidco/features/form_response/domain/repositories/form_response_repo.dart';
import 'package:saidco/features/form_response/domain/usecases/delete_form_response.dart';
import 'package:saidco/features/form_response/domain/usecases/get_form_responses.dart';
import 'package:saidco/features/form_response/presentation/cubit/form_response_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Feature - Form Response

  sl.registerFactory(
    () => FormResponseCubit(getFormResponses: sl(), deleteFormResponse: sl()),
  );

  sl.registerLazySingleton(() => GetFormResponses(sl()));
  sl.registerLazySingleton(() => DeleteFormResponse(sl()));

  sl.registerLazySingleton<FormResponseRepo>(() => FormResponseRepoImpl(sl()));

  sl.registerLazySingleton<FormRemoteDataSource>(
    () => FormRemoteDataSourceImpl(firestore: sl()),
  );

  //External Services

  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
