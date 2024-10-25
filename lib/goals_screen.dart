import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  List<Map<String, dynamic>> goals = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadGoals(); // Load goals from Firestore when the screen initializes
  }

  // Load goals from Firestore
  Future<void> loadGoals() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('goals').get();
      setState(() {
        goals = snapshot.docs.map((doc) {
          return {
            'id': doc.id, // Include Firestore document ID
            'title': doc['title'],
            'progress': doc['progress'] ?? 0.0, // Default to 0.0 if progress is null
          };
        }).toList();
      });
    } catch (e) {
      print("Error loading goals: $e"); // Handle loading errors
    }
  }

  // Update goal progress
  Future<void> updateProgress(int index, double progress) async {
    try {
      setState(() {
        goals[index]['progress'] = progress;
      });
      // Update Firestore
      await _firestore.collection('goals').doc(goals[index]['id']).update({'progress': progress});
    } catch (e) {
      print("Error updating progress: $e"); // Handle update errors
    }
  }

  // Add a new goal
  Future<void> addGoal(String title) async {
    try {
      // Create a new goal and add it to Firestore
      Map<String, dynamic> newGoal = {'title': title, 'progress': 0.0};
      DocumentReference docRef = await _firestore.collection('goals').add(newGoal);
      setState(() {
        newGoal['id'] = docRef.id; // Add Firestore document ID to the goal
        goals.add(newGoal);
      });
    } catch (e) {
      print("Error adding goal: $e"); // Handle adding errors
    }
  }

  // Show dialog to add a new goal
  void showAddGoalDialog() {
    TextEditingController goalController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Goal'),
          content: TextField(
            controller: goalController,
            decoration: InputDecoration(hintText: 'Enter your goal'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String goalTitle = goalController.text.trim();
                if (goalTitle.isNotEmpty) {
                  addGoal(goalTitle);
                  Navigator.of(context).pop();
                } else {
                  // Show a message if the title is empty
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Goal title cannot be empty.')));
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('My Goals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: goals.isEmpty // Check if there are no goals to display a message
            ? Center(child: Text('No goals added yet.'))
            : ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goal['title'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade800,
                            ),
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: goal['progress'],
                            backgroundColor: Colors.teal.shade100,
                            color: Colors.teal,
                            minHeight: 6,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Mark progress
                                  updateProgress(index, (goal['progress'] + 0.1).clamp(0.0, 1.0));
                                },
                                child: Text('Mark Progress'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddGoalDialog,
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}
