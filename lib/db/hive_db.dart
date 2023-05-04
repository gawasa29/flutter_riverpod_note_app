import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_note_app/models/note.dart';
import 'package:hive_flutter/hive_flutter.dart';

final dbProvider = Provider<HiveDB>((ref) => HiveDB());

class HiveDB {
  final _myBox = Hive.box('NOTE_DB');

  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];
    if (_myBox.get('ALL_NOTES') != null) {
      List<dynamic> savedNotes = _myBox.get('ALL_NOTES');
      for (int i = 0; i < savedNotes.length; i++) {
        Note singleNote = Note(
          id: savedNotes[i][0],
          title: savedNotes[i][1],
          text: savedNotes[i][2],
        );
        savedNotesFormatted.add(singleNote);
      }
    } else {
      savedNotesFormatted.add(const Note(
        id: "0",
        title: 'Tutorial',
        text:
            "This sample application has basic note-taking capabilities. Swipe left to delete a note. Rest assured that the data will be saved even if the app goes to the backend and is deleted as is.",
      ));
    }

    return savedNotesFormatted;
  }

  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];
    //プリミティブデータに変換が必要
    for (var note in allNotes) {
      String id = note.id;
      String title = note.title;
      String text = note.text;
      allNotesFormatted.add([id, title, text]);
    }
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
