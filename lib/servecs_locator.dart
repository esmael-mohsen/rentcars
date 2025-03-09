import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:rentapp/data/repo/car_repo_implment.dart';
import 'package:rentapp/data/source/firebase_data_source.dart';
import 'package:rentapp/domain/repo/car_repo.dart';
import 'package:rentapp/domain/usecase/cars_usecase.dart';
import 'package:rentapp/presentation/home/bloc/car_bloc.dart';

GetIt sl = GetIt.instance;
void setupServiceLocator() {
  try {
    sl.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance,
    );
    sl.registerLazySingleton<FirebaseDataSource>(
      () => FirebaseDataSource(firestore: sl()),
    );
    sl.registerLazySingleton<CarRepo>(() => CarRepoImplment(dataSource: sl()));
    sl.registerLazySingleton<CarsUsecase>(() => CarsUsecase(sl()));
    sl.registerFactory<CarBloc>(() => CarBloc(getCars: sl()));
  } catch (e) {
    print('Service Locator Error: $e');
  }
}
