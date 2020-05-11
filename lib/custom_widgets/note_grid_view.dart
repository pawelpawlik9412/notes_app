import 'package:flutter/material.dart';
import 'package:notes_app/model/note.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/notes_data.dart';
import 'package:notes_app/custom_widgets/card_grid_view.dart';
import 'package:notes_app/size_config.dart';

class NoteGridView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Note>>(
      future: Provider.of<NotesData>(context).getAllItems(context),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          List<Note> list = snapshot.data;
          return Scrollbar(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier),
                itemCount: list.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: SizeConfig.portraitOrientation ? 2 : 4,
                  childAspectRatio: (50.0 / 60.0),
                ),
                itemBuilder: (BuildContext context, int index) {
                  final note = list[index];
                  return CardGridView(
                    id: note.id,
                    title: note.title,
                    content: note.content,
                    createDate: note.createDate,
                    updateDate: note.updateDate,
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