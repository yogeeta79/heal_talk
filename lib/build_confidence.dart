import 'package:flutter/material.dart';
import 'dart:math';

class BuildConfidenceScreen extends StatefulWidget {
  @override
  _BuildConfidenceScreenState createState() => _BuildConfidenceScreenState();
}

class _BuildConfidenceScreenState extends State<BuildConfidenceScreen> {
  final List<String> motivationalParagraphs = [
    "Believe in yourself! Every small step you take brings you closer to your goals. Embrace the journey, trust your abilities, and know that you are capable of achieving great things.",
    "You are stronger than you think. Every challenge you face is an opportunity to grow and learn. Remember, the only limits that exist are the ones you place on yourself. Push through and rise above!",
    "Success is not defined by how others see you, but by how you see yourself. Have confidence in your abilities and take pride in your achievements. You have the power to shape your own destiny!",
    "Every day is a new opportunity to improve yourself. Take it and make the most of it. You are a work in progress and you should embrace that. Keep moving forward!",
    "Mistakes are proof that you are trying. Every experience you encounter is a stepping stone towards personal growth. So, don’t be afraid to take risks and embrace the unknown!"
  ];

  late String currentParagraph;

  @override
  void initState() {
    super.initState();
    // Select a random paragraph when the screen initializes
    currentParagraph = _getRandomParagraph();
  }

  String _getRandomParagraph() {
    final random = Random();
    return motivationalParagraphs[random.nextInt(motivationalParagraphs.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Build Confidence"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Build Confidence",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Placeholder for the illustration
            Image.network(
              "https://example.com/illustration.png", // Replace with actual illustration URL
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              currentParagraph,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Update paragraph when button is pressed
          setState(() {
            currentParagraph = _getRandomParagraph();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
