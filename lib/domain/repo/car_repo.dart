import 'package:rentapp/data/models/car_model.dart';

abstract class CarRepo {
  Future<List<CarModel>> fetchCars();
}