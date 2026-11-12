Food Waste Management System

A real-time food donation and recipient-matching platform designed to reduce food waste by connecting food donors with nearby individuals and communities in need.

Built with: Flutter, Dart, Firebase, Cloud Firestore, Firebase Authentication, Cloud Functions, and Firebase Cloud Messaging (FCM).

Problem Statement

Food waste and food insecurity remain significant challenges in Cameroon. Restaurants, supermarkets, markets, and households often have surplus food that goes to waste, while individuals and communities struggle to access sufficient food.

The lack of an efficient, real-time platform for connecting food donors with potential recipients makes it difficult to redistribute surplus food before it expires.

Solution

The Food Waste Management System provides a mobile platform that facilitates the donation and redistribution of surplus food. It connects donors with nearby recipients based on geographical location, food availability, and expiry dates.

By providing real-time updates and automated notifications, the system helps ensure that available food reaches people who need it before it goes to waste.

System Architecture

The application follows a structured architecture built around Flutter and Firebase.

- Frontend: Flutter and Dart for cross-platform mobile application development.
- Backend: Firebase for cloud infrastructure and backend services.
- Database: Cloud Firestore for real-time data storage and synchronization.
- Authentication: Firebase Authentication for secure user registration and login.
- Cloud Functions: Automated backend operations, expiry monitoring, and notification triggers.
- Push Notifications: Firebase Cloud Messaging (FCM) for real-time alerts.

Core Data Models

- Donors: User information, geographical location, and food inventory.
- Donations: Food descriptions, categories, quantities, expiry dates, and availability status.
- Recipients: User information, location, and food requirements.
- Matches: Connections between available donations and potential recipients.

Key Features

- Food Donation Management: Donors can upload surplus food with descriptions, quantities, locations, and expiry dates.
- Real-Time Food Discovery: Recipients can view available food donations as they are published.
- Location-Based Matching: Helps recipients discover available donations within their geographical area.
- Role-Based Dashboards: Separate interfaces and functionalities for donors and recipients.
- Expiry Monitoring: Prioritizes donations approaching their expiry dates.
- Automated Notifications: Sends notifications about new donations and relevant food availability.
- Donation History: Allows users to track previous donation and collection activities.
- Impact Analytics: Tracks meals saved and estimated food waste diverted through the platform.

Intelligent Matching Mechanism

The platform uses a location-aware and expiry-priority matching approach to improve food redistribution.

1. Location Prioritization: Identifies potential recipients based on their proximity to available donations.
2. Expiry Prioritization: Gives higher priority to food donations approaching their expiry dates.
3. Real-Time Synchronization: Updates donation availability through Cloud Firestore.
4. Automated Alerts: Uses Firebase Cloud Functions and FCM to notify relevant users about available donations. 
Technology Stack

Technology| Purpose
Flutter| Mobile application development
Dart| Application programming language
Firebase Authentication| User authentication
Cloud Firestore| Real-time database
Firebase Cloud Functions| Backend automation
Firebase Cloud Messaging| Push notifications
Google Maps| Location-based food discovery

Installation and Setup

To run the project locally:

1. Clone the repository

git clone YOUR_REPOSITORY_URL

2. Navigate to the project directory

cd food-waste-management-system

3. Install dependencies

flutter pub get

4. Configure Firebase

Add your Firebase configuration files and ensure the required Firebase services are enabled.

5. Run the application

flutter run

Future Improvements

- Predictive Food Surplus Forecasting: Implement machine learning models to predict food surplus using historical donation data.
- Optimized Matching Algorithm: Introduce multi-criteria decision-making techniques to improve donor-recipient matching.
- Advanced Analytics: Provide more detailed insights into food redistribution and community impact.
- Scalability: Extend the platform to support additional municipalities and communities across Cameroon.

Academic Project

Developed as a Bachelor of Science (BSc) Software Engineering Final Year Project, University of Bamenda, Cameroon, during the 2024/2025 academic year.

Project Title: A Food Waste Management System Within the Buea Municipality.

---

Using technology to reduce food waste, improve food accessibility, and build stronger communities.
