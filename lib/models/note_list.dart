import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_note_app/db/hive_db.dart';

import 'note.dart';

final noteListProvider =
    StateNotifierProvider.autoDispose<NoteList, List<Note>>(
  (ref) => NoteList(ref),
);

class NoteList extends StateNotifier<List<Note>> {
  NoteList(this._ref) : super(_ref.watch(dbProvider).loadNotes());

  final Ref _ref;
  Future<void> createNote({
    required String id,
  }) async {
    state = [
      ...state,
      Note(id: id, text: '', title: ''),
    ];
  }

  Future<void> updateNote(
      {required String id, required String title, required String text}) async {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Note(
            id: todo.id,
            text: text,
            title: title,
          )
        else
          todo,
    ];
    _ref.watch(dbProvider).savedNotes(state);
  }

  Future<void> deleteNote({required String id}) async {
    state = state.where((note) => note.id != id).toList();
    _ref.watch(dbProvider).savedNotes(state);
  }
}
