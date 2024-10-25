import 'dart:async';
import 'package:flutter/material.dart';

class MeditationScreen extends StatefulWidget {
  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  final List<Map<String, dynamic>> sessions = [
    {
      'title': 'Quick Stress Relief - 5 minutes',
      'image': 'assets/images/stress_relief.jpg',
      'tip': 'Take a deep breath and let your thoughts float away like clouds in the sky.',
      'isRunning': false,
      'elapsedSeconds': 0,
    },
    {
      'title': 'Morning Focus - 10 minutes',
      'image': 'assets/images/morning_focus.jpg',
      'tip': 'Visualize a positive outcome for the day ahead while breathing deeply.',
      'isRunning': false,
      'elapsedSeconds': 0,
    },
    {
      'title': 'Sleep Aid - 15 minutes',
      'image': 'assets/images/sleep_aid.jpg',
      'tip': 'Focus on the sound of your breath, letting each exhale release any tension.',
      'isRunning': false,
      'elapsedSeconds': 0,
    },
  ];

  Timer? timer;
  int currentSessionIndex = -1;

  void startTimer(int index) {
    setState(() {
      sessions[index]['isRunning'] = true;
      currentSessionIndex = index;
    });
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        sessions[index]['elapsedSeconds']++;
      });
    });
  }

  void stopTimer(int index) {
    if (timer != null) {
      timer!.cancel();
    }
    setState(() {
      sessions[index]['isRunning'] = false;
      currentSessionIndex = -1;
    });
  }

  String getElapsedTime(int index) {
    int elapsedSeconds = sessions[index]['elapsedSeconds'];
    int minutes = elapsedSeconds ~/ 60;
    int seconds = elapsedSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void resetTimer(int index) {
    stopTimer(index);
    setState(() {
      sessions[index]['elapsedSeconds'] = 0;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Meditation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: sessions.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.asset(
                      sessions[index]['image'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sessions[index]['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          sessions[index]['tip'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.teal.shade600,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Elapsed Time: ${getElapsedTime(index)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: sessions[index]['isRunning']
                                  ? null
                                  : () => startTimer(index),
                              icon: Icon(Icons.play_circle_fill),
                              label: Text('Start'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: sessions[index]['isRunning']
                                  ? () => stopTimer(index)
                                  : null,
                              icon: Icon(Icons.stop_circle),
                              label: Text('Stop'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: !sessions[index]['isRunning'] &&
                                      sessions[index]['elapsedSeconds'] > 0
                                  ? () => resetTimer(index)
                                  : null,
                              icon: Icon(Icons.replay),
                              label: Text('Reset'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
