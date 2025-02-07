
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class MyPins extends StatefulWidget {
  const MyPins({Key? key}) : super(key: key);

  @override
  _MyPinsState createState() => _MyPinsState();
}

class _MyPinsState extends State<MyPins> {
  LatLng? _currentPosition;
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  bool _isLoading = true; // Add a loading indicator flag

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadMyPins();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location services are disabled.')));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      if (_mapController != null && _currentPosition != null) {
        _mapController!.animateCamera(CameraUpdate.newLatLngZoom(_currentPosition!, 15));
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error getting location: ${e.toString()}')));
    }
  }

  Future<void> _loadMyPins() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle case where the user is not logged in
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not logged in')));
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final String userId = user.uid;

    // Load Donation Locations
    FirebaseFirestore.instance
        .collection('donations')
        .where('userId', isEqualTo: userId) // Filter by user ID
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
              snippet: 'Food Items: ${doc['foodItems']}\nDescription: ${doc['description']}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ),
        );
      });
    }).catchError((error) => print("Failed to load donation markers: $error"));

    // Load Request Locations
    FirebaseFirestore.instance
        .collection('requests')
        .where('userId', isEqualTo: userId) // Filter by user ID
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        GeoPoint location = doc['location'];
        _markers.add(
          Marker(
            markerId: MarkerId(doc.id + '_request'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
              title: doc['receiverName'],
              snippet: 'Description: ${doc['description']}',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      });
    }).catchError((error) => print("Failed to load request markers: $error"));

    setState(() {
      _isLoading = false; // Set loading to false after loading markers
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pins'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_currentPosition == null) // Check if current location is available
          ? const Center(child: Text('Getting current location...'))
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        markers: _markers,
        myLocationEnabled: true,  // Show current location
        myLocationButtonEnabled: true, // Button to focus on current location
      ),
    );
  }
}

