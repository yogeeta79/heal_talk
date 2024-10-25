import 'package:flutter/material.dart';
import 'goals_screen.dart';
import 'journal_screen.dart';
import 'meditation_screen.dart';
import 'mood_tracking_screen.dart';
import 'profile_screen.dart';
import 'package:heal_talk/build_confidence.dart'; // Import the BuildConfidenceScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          'HealTalk',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              SizedBox(height: 20),
              
              // Build Confidence Section
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuildConfidenceScreen()), // Navigate to BuildConfidenceScreen
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade100, Colors.teal.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.teal.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Build Confidence',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap here for motivational insights',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Features Section
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildFeatureContainer(
                    context,
                    title: 'Goals',
                    imageUrl:
                        'https://images.unsplash.com/photo-1580631365999-95f0ef2908ae?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60',
                    description: 'Track your progress',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoalsScreen()),
                      );
                    },
                  ),
                  _buildFeatureContainer(
                    context,
                    title: 'Journal',
                    imageUrl:
                        'https://images.unsplash.com/photo-1501529307352-5922e4023a29?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60',
                    description: 'Reflect on your thoughts',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JournalScreen()),
                      );
                    },
                  ),
                  _buildFeatureContainer(
                    context,
                    title: 'Meditation',
                    imageUrl:
                        'https://images.unsplash.com/photo-1552089124-241a52f5e55b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60',
                    description: 'Find your calm',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MeditationScreen()),
                      );
                    },
                  ),
                  _buildFeatureContainer(
                    context,
                    title: 'Mood Tracker',
                    imageUrl:
                        'https://images.unsplash.com/photo-1494883759339-0b042055a4ee?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60',
                    description: 'Track your emotions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoodTrackingScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureContainer(BuildContext context,
      {required String title,
      required String imageUrl,
      required String description,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
