import 'package:rentapp/data/models/car_model.dart';
import 'package:rentapp/data/source/firebase_data_source.dart';
import 'package:rentapp/domain/repo/car_repo.dart';

class CarRepoImplment extends CarRepo {
  final FirebaseDataSource dataSource;
  CarRepoImplment({required this.dataSource});
  @override
  Future<List<CarModel>> fetchCars() {
    return dataSource.getCars();
  }
}
