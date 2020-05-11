import 'package:flutter/material.dart';
import 'package:notes_app/custom_widgets/card_list_view.dart';
import 'package:notes_app/providers/notes_data.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/model/note.dart';
import 'package:notes_app/size_config.dart';


class NoteListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: Provider.of<NotesData>(context).getAllItems(context),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Note> list = snapshot.data;
          return Scrollbar(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, index) {
                  final note = list[index];
                  return Dismissible(
                    key: Key(note.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      try {
                        Provider.of<NotesData>(context, listen: false).deleteNote(note.id, context);
                        list.removeAt(index);
                      } catch (e) {
                        print(e);
                      }
                    },
                    background: Container(
                      margin: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                      color: Colors.redAccent,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 8),
                          child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: SizeConfig.heightMultiplier * 3.5,
                          ),
                        ),
                      ),
                    ),
                    child: CardListView(
                      id: note.id,
                      title: note.title,
                      content: note.content,
                      createDate: note.createDate,
                      updateDate: note.updateDate,
                    ),
                  );
                }
            ),
          );
        }
        else {
          return Center(
              child: CircularProgressIndicator()
          );
        }
      },
    );
  }
}