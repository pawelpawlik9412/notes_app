import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/model/shared_pref.dart';
import 'package:notes_app/custom_widgets/note_list_view.dart';
import 'package:notes_app/custom_widgets/note_grid_view.dart';



class PreferencesData extends ChangeNotifier {

  String title ='Sort by title';
  String creationDate = 'Sort by creation date';
  String editionDate = 'Sort by edition date';

  String tableView = 'table_view';
  String gridView = 'grid_view';

  static final _sortPref = SharedPref(instanceName: 'sort_by', deflautValue: 'createDate DESC');
  static final _viewPref = SharedPref(instanceName: 'view', deflautValue: 'table_view');

  Future<String> getSortPreferences() async {
    var x = await _sortPref.read();
    return x;
  }

  void safeSortPreferences(String value) {
    _sortPref.save(value);
    notifyListeners();
  }

  void removeSortPreferences() {
    _sortPref.remove();
    notifyListeners();
  }

  Future<String> getStringForSortButton() async {
    var x = await _sortPref.read();
    String y;
    if (x == 'title') {
      y = title;
    }
    else if (x == 'createDate DESC') {
      y = creationDate;
    }
    else if (x == 'updateDate DESC') {
      y = editionDate;
    }
    return y;
  }








  Future<String> getViewPreferences() async {
    var x = await _viewPref.read();
    return x;
  }

  void safeViewPreferences(String value) {
    _viewPref.save(value);
    notifyListeners();
  }

  void removeViewPreferences() {
    _viewPref.remove();
    notifyListeners();
  }

  Future<Map> getViewDetail() async {
    var x = await _viewPref.read();
    Map<String, dynamic> map = {};
    if (x == tableView) {
      map['iconData'] = Icons.view_module;
      map['viewData'] = NoteListView();
    }
    else if (x == gridView) {
      map['iconData'] = Icons.view_stream;
      map['viewData'] = NoteGridView();
    }
    return map;
  }

  Future<void> changeViewPreferences() async {
    var x = await getViewPreferences();
    if (x == tableView) {
      safeViewPreferences(gridView);
    } else if (x == gridView) {
      safeViewPreferences(tableView);
    }
    notifyListeners();
  }

}