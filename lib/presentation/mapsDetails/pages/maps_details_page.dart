import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rentapp/data/models/car_model.dart';
import 'package:rentapp/presentation/mapsDetails/widgets/details_card.dart';

class MapsDetailsPage extends StatefulWidget {
  final CarModel car;
  const MapsDetailsPage({super.key, required this.car});

  @override
  _MapsDetailsPageState createState() => _MapsDetailsPageState();
}

class _MapsDetailsPageState extends State<MapsDetailsPage> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController();
  double _currentZoom = 13.0; // Default Zoom Level

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location services are disabled.")),
      );
      return;
    }

    // Request permission if needed
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Location permission is permanently denied."),
          ),
        );
        return;
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });

    // Move map to the new location
    _mapController.move(_currentLocation!, _currentZoom);
  }

  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).iconTheme.color,
                size: 20,
              ),
            ),
          ),
        ),
        title: const Text('Location', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, color: Colors.black),
            onPressed: _getUserLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          _FlutterMap(
            mapController: _mapController,
            currentLocation: _currentLocation,
            currentZoom: _currentZoom,
          ),
          _buildZoomButtons(),
          DetailesCard(car: widget.car,),
        ],
      ),
    );
  }

  Widget _buildZoomButtons() {
    return Positioned(
      top: 120,
      right: 10,
      child: Column(
        children: [
          FloatingActionButton(
            onPressed: _zoomIn,
            mini: true,
            backgroundColor: Colors.white,
            heroTag: "zoomInButton", // ✅ Unique tag
            child: const Icon(Icons.add, color: Colors.black),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: _zoomOut,
            mini: true,
            backgroundColor: Colors.white,
            heroTag: "zoomOutButton", // ✅ Unique tag
            child: const Icon(Icons.remove, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class _FlutterMap extends StatelessWidget {
  const _FlutterMap({
    required MapController mapController,
    required LatLng? currentLocation,
    required double currentZoom,
  }) : _mapController = mapController,
       _currentLocation = currentLocation,
       _currentZoom = currentZoom;

  final MapController _mapController;
  final LatLng? _currentLocation;
  final double _currentZoom;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentLocation ?? LatLng(51.5, -0.09),
        initialZoom: _currentZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        ),
        if (_currentLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: _currentLocation!,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
