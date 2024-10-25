import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _entryController = TextEditingController();
  List<Map<String, String>> entries = []; // To store entries with date
  String _currentPrompt = ''; // To store the current prompt

  
  final List<String> _prompts = [
    'What made you smile today?',
    'Describe a moment you felt proud of yourself.',
    'What was the best part of your day?',
    'What are three things you are grateful for today?',
    'What was a challenge you faced today, and how did you handle it?',
  ];

  @override
  void initState() {
    super.initState();
    _loadEntries();
    _setRandomPrompt(); 
  }

  Future<void> _loadEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEntries = prefs.getString('journal_entries');
    if (savedEntries != null) {
      setState(() {
        entries = List<Map<String, String>>.from(json.decode(savedEntries));
      });
    }
  }

  Future<void> _saveEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('journal_entries', json.encode(entries));
  }

  void _setRandomPrompt() {
    setState(() {
      _currentPrompt = _prompts[Random().nextInt(_prompts.length)];
    });
  }

  void _addEntry() {
    if (_entryController.text.isNotEmpty) {
      setState(() {
        entries.add({
          'text': _entryController.text,
          'date': DateTime.now().toLocal().toString().split(' ')[0], // Store only the date
        });
        _entryController.clear();
        _saveEntries();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Journal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display the current prompt
            Text(
              'Today\'s Prompt: $_currentPrompt',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.teal.shade800,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _entryController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Write about your day...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addEntry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text('Save Entry', style: TextStyle(color:Colors.white),)
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        'Entry ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(entries[index]['text'] ?? ''),
                          const SizedBox(height: 4), 
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              entries[index]['date'] ?? '',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.teal.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
