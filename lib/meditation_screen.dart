import 'dart:async';
import 'package:flutter/material.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  final List<Map<String, dynamic>> sessions = [
    {
      'title': 'Quick Stress Relief - 5 minutes',
      'image': 'assets/images/first.png',
      'tip': 'Take a deep breath and let your thoughts float away like clouds in the sky.',
      'isRunning': false,
      'elapsedSeconds': 0,
    },
    {
      'title': 'Morning Focus - 10 minutes',
      'image': 'assets/images/second.png',
      'tip': 'Visualize a positive outcome for the day ahead while breathing deeply.',
      'isRunning': false,
      'elapsedSeconds': 0,
    },
    {
      'title': 'Sleep Aid - 15 minutes',
      'image': 'assets/images/third.png',
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
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
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
        title: const Text('Meditation'),
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
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
                        const SizedBox(height: 8),
                        Text(
                          sessions[index]['tip'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.teal.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Elapsed Time: ${getElapsedTime(index)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed: sessions[index]['isRunning']
                                  ? null
                                  : () => startTimer(index),
                              icon: const Icon(Icons.play_circle_fill),
                              label: const Text('Start',style: TextStyle(color:Colors.white),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: sessions[index]['isRunning']
                                  ? () => stopTimer(index)
                                  : null,
                              icon: const Icon(Icons.stop_circle),
                              label: const Text('Stop'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: !sessions[index]['isRunning'] &&
                                      sessions[index]['elapsedSeconds'] > 0
                                  ? () => resetTimer(index)
                                  : null,
                              icon: const Icon(Icons.replay),
                              label: const Text('Reset'),
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
