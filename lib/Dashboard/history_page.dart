import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonationHistoryPage extends StatelessWidget {
  const DonationHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donations')
            .orderBy('timestamp', descending: true) // Order by timestamp
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No donations found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final document = snapshot.data!.docs[index];
              final data = document.data() as Map<String, dynamic>;

              // Extract data from the document
              final donorName = data['donorName'] as String? ?? 'N/A';
              final foodItems = data['foodItems'] as String? ?? 'N/A';
              final phoneNumber = data['phoneNumber'] as String? ?? 'N/A';
              final description = data['description'] as String? ?? '';
              final timestamp = data['timestamp'] as Timestamp?;
              final GeoPoint location = data['location'] as GeoPoint;

              // Format the timestamp
              String formattedDate = 'N/A';
              if (timestamp != null) {
                final dateTime = timestamp.toDate();
                formattedDate = DateFormat('yyyy-MM-dd HH:mm')
                    .format(dateTime); // Customize format
              }

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Donor: $donorName',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8.0),
                      Text('Food Items: $foodItems'),
                      Text('Phone: $phoneNumber'),
                      Text('Description: $description'),
                      Text('Date: $formattedDate'),
                      const SizedBox(height: 8.0),
                      SizedBox(
                        height: 150,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target:
                                LatLng(location.latitude, location.longitude),
                            zoom: 15,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId('donation_location'),
                              position:
                                  LatLng(location.latitude, location.longitude),
                              infoWindow: InfoWindow(
                                  title: 'Donation Location',
                                  snippet: donorName),
                            ),
                          },
                          zoomControlsEnabled: false,
                          // Optional: disable zoom controls
                          scrollGesturesEnabled: false,
                          // Optional: disable scrolling
                          mapType: MapType.normal, // Optional: set map type
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
