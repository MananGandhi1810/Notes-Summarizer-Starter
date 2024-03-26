import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_page.dart';
import 'note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = [];
  late SharedPreferences _prefs;
  final months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final colors = [
    Colors.red[400],
    Colors.green[400],
    Colors.blue[400],
    Colors.purple[400],
    Colors.orange[400],
    Colors.pink[400],
    Colors.teal[400],
  ];

  void _loadNotes() async {
    _prefs = await SharedPreferences.getInstance();
    final notes = _prefs.getStringList('notes');
    if (notes != null) {
      setState(() {
        _notes = notes.map((note) => Note.fromJson(jsonDecode(note))).toList();
      });
      debugPrint('Notes loaded: $_notes');
    }
  }

  void _newNote() async {
    final newNote = Note(
      id: DateTime.now().toString(),
      title: '',
      content: '',
      summary: '',
      lastEdited: DateTime.now(),
    );
    _notes.add(newNote);
    await _prefs.setStringList(
      'notes',
      _notes.map((note) => jsonEncode(note.toJson())).toList(),
    );
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => EditPage(
              id: newNote.id,
            ),
          ),
        )
        .then((value) => _loadNotes());
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Container(),
      floatingActionButton: Container(),
    );
  }
}
