import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ietp/locations.dart';
import 'package:ietp/map_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentIndex = 0; // Index of the current tab
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  Future<Position?> _getCurrentLocation() async {
    try {
      servicePermission = await Geolocator.isLocationServiceEnabled();

      if (!servicePermission) {
        print("Service Disabled");
        return null; // Indicate error or handle appropriately
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position location = await Geolocator.getCurrentPosition();
      return location;
    } catch (e) {
      // Handle exception, e.g., display an error message to the user
      print("Error getting location: $e");
      return null;
    }
  }

  Future<void> _getUserLocation() async {
    try {
      // Check permissions and handle errors as before
      _currentLocation = await _getCurrentLocation();
      if (_currentLocation != null) {
        List<Location> sortedLocations =
            sortLocationsByDistance(_currentLocation!, Location.positions);
        // for (int i = 0; i < sortedLocations.length; i++){
        //   debugPrint(sortedLocations[i].name);
        // }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MapPage(
              sortedLocation: sortedLocations,
              latitude: _currentLocation!.latitude,
              longitude: _currentLocation!.longitude,
            ),
          ),
        );
      } else {
        // Handle case where location couldn't be retrieved
        return null;
      }
    } catch (e) {
      // Handle exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Safe Sprinkler System',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 230,
                child: ElevatedButton(
                  onPressed: () async {
                    _getUserLocation();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text('Map'),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

 
}
