import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/database/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/preferences_data.dart';

class NotesData extends ChangeNotifier {

  var _db = DatabaseHelper.db;

  Note selectedNote;

  get getDB {
    return _db.database;
  }

  get getNumberOfNotes async {
    var x = await _db.getNumberOfNotes();
    return x;
  }

  Future<List<Note>> getAllItems(context) async {
    var y = await Provider.of<PreferencesData>(context).getSortPreferences();
    var x = await _db.getAllNotes(y);
    return x;
  }

//  Future<Note> getFirstNote(context) async {
//    var y = await Provider.of<PreferencesData>(context, listen:  false).getSortPreferences();
//    var result;
//    try {
//      var x = await _db.getAllNotes(y);
//      result = x[0];
//    }
//    catch (e) {
//      print(e);
//    }
//    return result;
//  }

  Future<Note> getFirstNote(context) async {
    var y = await Provider.of<PreferencesData>(context, listen:  false).getSortPreferences();
    var x = await _db.getAllNotes(y);
    var result;

    try {
      result = x[0];
    }
    catch (e) {
      print(e);
      result = null;
    }
    return result;
  }


  void addNote(Note note) {
    _db.insertNote(note);
    notifyListeners();
  }

//  void deleteNote(int noteId, context) async {
//    _db.deleteNote(noteId);
//
//    if (selectedNote == null || noteId == selectedNote.id) {
//      var y = await getFirstNote(context);
//      setSelectedNote(y.id);
//    }
//    notifyListeners();
//  }

  void deleteNote(int noteId, context) async {
    _db.deleteNote(noteId);
    var y = await getFirstNote(context);
    print(y);

    if (y == null) {
      selectedNote = null;
    }
    else if(selectedNote == null || noteId == selectedNote.id || y != null) {
      setSelectedNote(y.id);
    }
    notifyListeners();
  }

  void updateNote(int noteId, String titleUpdate, String contentUpdate, String dateUpdate) {
    _db.updateNote(noteId, titleUpdate, contentUpdate, dateUpdate);
    notifyListeners();
    if(selectedNote == null) {
      return;
    }
    else if(noteId == selectedNote.id) {
      selectedNote.title = titleUpdate;
      selectedNote.content = contentUpdate;
      selectedNote.updateDate = dateUpdate;
    }
    notifyListeners();
  }

  Future<void> setSelectedNote(noteId) async {
    var x = await _db.getNote(noteId);
    selectedNote = x;
    notifyListeners();
  }

  Future<Note> getNoteForDetailView(context) async {
    Note note;
    if(selectedNote == null) {
      note = await getFirstNote(context);
    }
    else {
      note = selectedNote;
    }
    return note;
  }
}