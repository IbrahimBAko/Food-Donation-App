import 'package:flutter/material.dart';
import 'package:foodwaste/Welcome/about_us.dart';
import 'package:foodwaste/Welcome/login_page.dart';
import 'package:foodwaste/Welcome/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to FoodDonor', style: TextStyle(color: Colors.purple),),
      ),
      backgroundColor: Colors.black45, // Set background color to a light gray
      body: Center( // Wrap with Center widget
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Start alignment
            crossAxisAlignment: CrossAxisAlignment.center, // Horizontal centering
            children: <Widget>[
              const SizedBox(height: 5), // Added top spacing
              const Text(
                'Get Started!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
              const SizedBox(height: 40),

              // Login
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey, // Set background color of Container to black
                      child: Image.asset(
                        'assets/images/Login.png',
                        width: 350, // Increased width
                        height: 150, // Increased height
                      ),
                    ),
                    const Text('LOGIN', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)), // Text label
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Register
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey, // Set background color of Container to black
                      child: Image.asset(
                        'assets/images/Sign up.png',
                        width: 350, // Increased width
                        height: 150, // Increased height
                      ),
                    ),
                    const Text('SIGN UP', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)), // Text label
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // About Us
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUs()),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey, // Set background color of Container to black
                      child: Image.asset(
                        'assets/images/About Us.jpg',
                        width: 350, // Increased width
                        height: 150, // Increased height
                      ),
                    ),
                    const Text('ABOUT US', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)), // Text label
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
