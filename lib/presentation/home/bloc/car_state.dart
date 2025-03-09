import 'package:rentapp/data/models/car_model.dart';

abstract class CarState {}

class CarLoading extends CarState {}
class CarLoaded extends CarState {
  final List<CarModel> cars;
  CarLoaded({required this.cars});
}
class CarError extends CarState {
  final String message;
  CarError({required this.message});
}