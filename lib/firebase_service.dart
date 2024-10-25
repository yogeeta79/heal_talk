import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to add a mood entry to Firestore
  Future<void> addMood(String mood, DateTime date) async {
    try {
      await _firestore.collection('moods').add({
        'mood': mood,
        'date': date.toIso8601String(),
      });
      print('Mood added: $mood');
    } catch (e) {
      print('Error adding mood: $e');
    }
  }

  // Function to add a journal entry to Firestore
  Future<void> addJournalEntry(String entry, DateTime date) async {
    try {
      await _firestore.collection('journalEntries').add({
        'entry': entry,
        'date': date.toIso8601String(),
      });
      print('Journal entry added');
    } catch (e) {
      print('Error adding journal entry: $e');
    }
  }
}
