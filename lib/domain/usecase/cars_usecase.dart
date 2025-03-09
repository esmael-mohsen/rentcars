import 'package:rentapp/data/models/car_model.dart';
import 'package:rentapp/domain/repo/car_repo.dart';

class CarsUsecase {
  final CarRepo _carsRepository;

  CarsUsecase(this._carsRepository);

  Future<List<CarModel>> call() async {
    return await _carsRepository.fetchCars();
  }
}