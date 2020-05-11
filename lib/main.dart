import 'package:flutter/material.dart';
import 'package:notes_app/screens/screen_manager.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/notes_data.dart';
import 'package:notes_app/providers/preferences_data.dart';

void main() => runApp(NoteApp());

class NoteApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesData()),
        ChangeNotifierProvider(create: (_) => PreferencesData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: ScreenManager()
          ),
        ),
      ),
    );
  }
}

