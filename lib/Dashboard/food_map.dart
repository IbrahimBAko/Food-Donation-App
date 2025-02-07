import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodMaps extends StatefulWidget {
  const FoodMaps({Key? key}) : super(key: key);

  @override
  _FoodMapsState createState() => _FoodMapsState();
}

class _FoodMapsState extends State<FoodMaps> {
  LatLng? _currentPosition;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {}; // To store the markers

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadMarkers();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled.')));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      if (_mapController != null && _currentPosition != null) {
        _mapController!
            .animateCamera(CameraUpdate.newLatLngZoom(_currentPosition!, 15));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting location: ${e.toString()}')));
    }
  }

  Future<void> _loadMarkers() async {
    // Load Donor Locations
    FirebaseFirestore.instance
        .collection('donations')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        GeoPoint location = doc['location'];
        _markers.add(
          Marker(
            markerId: MarkerId(doc.id + '_donor'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
              title: doc['donorName'],
              snippet:
                  'Food Items: ${doc['foodItems']}\nPhone: ${doc['phoneNumber']}\n${doc['description']}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen), // Donor marker
          ),
        );
      });
    }).catchError((error) => print("Failed to load donor markers: $error"));

    // Load Receiver Locations
    FirebaseFirestore.instance
        .collection('requests')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        GeoPoint location = doc['location'];
        _markers.add(
          Marker(
            markerId: MarkerId(doc.id + '_receiver'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
              title: doc['receiverName'],
              snippet: 'Phone: ${doc['phoneNumber']}\n${doc['description']}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed), // Receiver marker
          ),
        );
      });
    }).catchError((error) => print("Failed to load receiver markers: $error"));

    // After loading the markers, refresh the state
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Map'),
      ),
      body: _currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: _markers,
              myLocationEnabled: true,
              // Show current location
              myLocationButtonEnabled:
                  true, // Button to focus on current location
            ),
    );
  }
}
