
class CarModel {
  final String model;
  final int distance;
  final int fulCapacity;
  final int pricePerHour;
  final String image;

  CarModel( {required this.model,required this.image, required this.distance, required this.fulCapacity, required this.pricePerHour});

  
factory CarModel.fromMap(Map<String, dynamic> map) {
  return CarModel(
    model: map['model'],
    distance: map['distance'],
    fulCapacity: map['fulCapacity'],
    pricePerHour: map['pricePerHour'],
    image: map['image'],
  );
}
}

