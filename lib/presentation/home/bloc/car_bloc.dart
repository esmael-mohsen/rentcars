import 'package:bloc/bloc.dart';
import 'package:rentapp/data/models/car_model.dart';
import 'package:rentapp/domain/usecase/cars_usecase.dart';
import 'package:rentapp/presentation/home/bloc/car_events.dart';
import 'package:rentapp/presentation/home/bloc/car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarsUsecase getCars;
  List<CarModel> allCars = []; // ✅ Store all cars for filtering

  CarBloc({required this.getCars}) : super(CarLoading()) {
    on<LoadCars>(_onLoadCars);
    on<SearchCars>(_onSearchCars);
  }

  Future<void> _onLoadCars(LoadCars event, Emitter<CarState> emit) async {
    emit(CarLoading());
    try {
      allCars = await getCars.call();
      emit(CarLoaded(cars: allCars)); // ✅ Load all cars initially
    } catch (e) {
      emit(CarError(message: e.toString()));
    }
  }

  void _onSearchCars(SearchCars event, Emitter<CarState> emit) {
    final filteredCars =
        allCars.where((car) {
          final matchesName = car.model.toLowerCase().contains(
            event.name.toLowerCase(),
          );

          // ✅ Allow partial match for category (not exact match)
          final matchesCategory =
              event.category.isEmpty ||
              car.model.toLowerCase().contains(event.category.toLowerCase());

          return matchesName && matchesCategory;
        }).toList();

    emit(CarLoaded(cars: filteredCars)); // ✅ Update state with filtered cars
  }
}
