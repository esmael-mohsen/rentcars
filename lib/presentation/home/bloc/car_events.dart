abstract class CarEvent {}

class LoadCars extends CarEvent {}

class SearchCars extends CarEvent {
  final String name;
  final String category;

  SearchCars({required this.name, required this.category});
}
