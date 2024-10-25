import 'package:flutter/material.dart';

class MoodTrackingScreen extends StatefulWidget {
  const MoodTrackingScreen({super.key});

  @override
  _MoodTrackingScreenState createState() => _MoodTrackingScreenState();
}

class _MoodTrackingScreenState extends State<MoodTrackingScreen> {
  List<String> moods = ['😄', '🙂', '😐', '😔', '😢'];
  String? currentMood;

  void logMood(String mood) {
    setState(() {
      currentMood = mood;
    });
  }

  String getMoodMessage(String mood) {
    switch (mood) {
      case '😄':
        return 'It looks like you\'re feeling great! Keep up the positive vibes!';
      case '🙂':
        return 'Glad to see you\'re feeling good! Hope your day continues to be nice.';
      case '😐':
        return 'Feeling neutral is okay. Take some time to do something you enjoy.';
      case '😔':
        return 'I\'m sorry to hear you\'re feeling down. It\'s okay to take a break and take care of yourself.';
      case '😢':
        return 'It\'s tough when things feel this way. Remember, you\'re not alone—reach out to someone if you need to talk.';
      default:
        return 'How are you feeling today?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Mood Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'How are you feeling?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.teal.shade800,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: moods.map((mood) {
                return GestureDetector(
                  onTap: () => logMood(mood),
                  child: Text(
                    mood,
                    style: const TextStyle(fontSize: 32),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            if (currentMood != null)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Mood: $currentMood',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.teal.shade800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        getMoodMessage(currentMood!),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

