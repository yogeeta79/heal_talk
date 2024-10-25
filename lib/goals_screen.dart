import 'package:flutter/material.dart';
import 'preferences_helper.dart'; 

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  List<Map<String, dynamic>> goals = [];
  final PreferencesHelper _preferencesHelper = PreferencesHelper(); 
  
  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  void _loadGoals() async {
    List<Map<String, dynamic>> loadedGoals = await _preferencesHelper.loadGoals();
    setState(() {
      goals = loadedGoals;
    });
  }

  void _saveGoals() {
    _preferencesHelper.saveGoals(goals);
  }

  void updateProgress(int index, double progress) {
    setState(() {
      goals[index]['progress'] = progress;
    });
    _saveGoals(); 
  }

  void addGoal(String title) {
    setState(() {
      goals.add({'title': title, 'progress': 0.0});
    });
    _saveGoals(); 
  }

  void deleteGoal(int index) {
    setState(() {
      goals.removeAt(index);
    });
    _saveGoals(); 
  }

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
        child: ListView.builder(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          goal['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteGoal(index);
                          },
                        ),
                      ],
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
