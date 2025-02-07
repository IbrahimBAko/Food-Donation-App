import 'package:flutter/material.dart';
import 'package:foodwaste/Dashboard/contact_us.dart';
import 'package:foodwaste/Dashboard/donate_page.dart';
import 'package:foodwaste/Dashboard/food_map.dart';
import 'package:foodwaste/Dashboard/history_page.dart';
import 'package:foodwaste/Dashboard/my_pins.dart';
import 'package:foodwaste/Dashboard/receive_page.dart';
import 'package:foodwaste/Welcome/about_us.dart'; // Import AboutUs
import 'package:foodwaste/Welcome/login_page.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      backgroundColor: Colors.black45,
      body: GridView.count(
        crossAxisCount: 2, // 2 columns
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          _DashboardItem(
            imagePath: 'assets/images/Food donation.jpg',
            // Replace with your image path
            text: 'Donate',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Donate()),
              );
            },
          ),
          _DashboardItem(
            imagePath: 'assets/images/Food received.jpg',
            // Replace with your image path
            text: 'Receive',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Receive()),
              );
            },
          ),
          _DashboardItem(
            imagePath: 'assets/images/Food Maps.png',
            // Replace with your image path
            text: 'Food Maps',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FoodMaps()),
              );
            },
          ),
          _DashboardItem(
            imagePath: 'assets/images/My Pins.png',
            // Replace with your image path
            text: 'My Pins',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyPins()),
              );
            },
          ),
          _DashboardItem(
            imagePath: 'assets/images/history.jpg',
            // Replace with your image path
            text: 'History',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DonationHistoryPage()),
              );
            },
          ),
          _DashboardItem(
            imagePath: 'assets/images/About Us.jpg',
            // Replace with your image path
            text: 'About Us',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUs()),
              );
            },
          ),
          _DashboardItem(
            imagePath: 'assets/images/Contact us.jpg',
            // Replace with your image path
            text: 'Contact Us',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUsPage()),
              );
            },
          ),
          _DashboardItem(
            imagePath: 'assets/images/Logout.png',
            // Replace with your image path
            text: 'Logout',
            onTap: () {
              // Implement logout logic here (e.g., Firebase Auth sign out)
              // Then navigate to login page.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DashboardItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const _DashboardItem({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.grey[800], //Darker background for contrast
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: 80, // Adjust size as needed
                height: 80, // Adjust size as needed
                fit: BoxFit.cover, // Prevent stretching
              ),
              const SizedBox(height: 10),
              Text(
                text,
                style: const TextStyle(fontSize: 16,
                    color: Colors.white), //White text for readability
              ),
            ],
          ),
        ),
      ),
    );
  }
}

