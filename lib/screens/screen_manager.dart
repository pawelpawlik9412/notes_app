import 'package:flutter/material.dart';
import 'package:notes_app/size_config.dart';
import 'package:notes_app/screens/note_screen.dart';
import 'package:notes_app/screens/detail_screen_view.dart';
import 'package:notes_app/model/note.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/notes_data.dart';


class ScreenManager extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
              builder: (context, orientation) {
                SizeConfig().init(constraints, orientation);
                return Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: NoteScreen(),
                      ),
                    ),
                    SizeConfig().screenSize ? Container() : Expanded(
                      flex: 3,
                      child: FutureBuilder<Note>(
                        future: Provider.of<NotesData>(context).getNoteForDetailView(context),
                        builder:  (context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData) {
                            return DetailScreenView(
                              id: snapshot.data.toMap()['id'],
                              title: snapshot.data.toMap()['title'],
                              content: snapshot.data.toMap()['content'],
                              createDate: snapshot.data.toMap()['createDate'],
                              updateDate: snapshot.data.toMap()['updateDate'],
                            );
                          }
                          else {
                            return Text('');
                          }
                        },

                      ),
                    ),
                  ],
                );
              }
          );
        }
    );
  }
}
