import 'package:flutter/material.dart';
import 'package:ietp/locations.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPage extends StatefulWidget {
  const MapPage(
      {Key? key,
      required this.latitude,
      required this.longitude,
      required this.sortedLocation})
      : super(key: key);

  final double latitude;
  final double longitude;
  final List<Location> sortedLocation;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double? polyLatitude;
  double? polyLongitude;
  final MapController _mapController = MapController();

  double _currentZoom = 11; // Initialize zoom level
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Fire Stations Map', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          PopupMenuButton<Location>(
            onSelected: (Location selectedLocation) {
              setState(() {
                polyLatitude = selectedLocation.latitude;
                polyLongitude = selectedLocation.longitude;
              });
            },
            itemBuilder: (BuildContext context) {
              return widget.sortedLocation.map((Location location) {
                return PopupMenuItem<Location>(
                  value: location,
                  child: Text(location.name),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(widget.latitude, widget.longitude),
              initialZoom: _currentZoom,
              minZoom: 3, // Set your desired minimum zoom level
              maxZoom: 19, // Set your desired maximum zoom level
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(widget.latitude, widget.longitude),
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                  ),
                  const Marker(
                    //Akaki Kality
                    point: LatLng(8.871546, 38.788999),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Akaki Kality",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Marker(
                    //Nefas Silk
                    point: LatLng(8.948606, 38.7649),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Nefas Silk",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Marker(
                    point: LatLng(9.006456, 38.681882),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Bethel",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Marker(
                    point: LatLng(8.973223, 38.760955),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Kirkos",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Marker(
                    point: LatLng(9.05759, 38.713312),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Main",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Marker(
                    point: LatLng(9.033437, 38.724256),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Addis Ketema",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Marker(
                    point: LatLng(9.037573, 38.75321),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Addis HeadQuarter",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Marker(
                    point: LatLng(9.037687, 38.753776),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Arada",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  const Marker(
                    point: LatLng(9.05759, 38.713312),
                    width: 80,
                    height: 80,
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text(
                          "Tigist",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (polyLatitude != null && polyLongitude != null)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: [
                        LatLng(widget.latitude, widget.longitude),
                        LatLng(polyLatitude!, polyLongitude!)
                      ],
                      color: Colors.blue,
                      strokeWidth: 2.0,
                      // isDotted: true,
                    ),
                  ],
                ),
            ],
          ),
          // Add FABs for zoom in and zoom out
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black
                      .withOpacity(0.7), // Set semi-transparent black
                  heroTag: "zoomIn",
                  onPressed: _zoomIn,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Colors.black
                      .withOpacity(0.7), // Set semi-transparent black
                  heroTag: "zoomOut",
                  onPressed: _zoomOut,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _zoomIn() {
    setState(() {
      _currentZoom += 1.0;
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1.0;
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }
}