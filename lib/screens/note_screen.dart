import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/notes_data.dart';
import 'package:notes_app/custom_widgets/number_of_notes_text.dart';
import 'package:notes_app/providers/preferences_data.dart';
import 'package:notes_app/model/format_date.dart';
import 'package:notes_app/screens/detail_screen.dart';

class NoteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 4.0, left: SizeConfig.widthMultiplier * 3, right: SizeConfig.widthMultiplier * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: SizeConfig.textMultiplier * 5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizeConfig().screenSize ? FutureBuilder<Map>(
                        future: Provider.of<PreferencesData>(context).getViewDetail(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return IconButton(
                              icon: Icon(snapshot.data['iconData']),
                              onPressed: () {
                                Provider.of<PreferencesData>(context, listen: false).changeViewPreferences();
                              },
                            );
                          } else {
                            return Container();
                          }
                        },
                      ) : Container(),
                      IconButton(
                        icon: Icon(Icons.create),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return DetailScreen(
                                    id: null,
                                    title: null,
                                    content: null,
                                    createDate: FormatDate.getDate(),
                                    updateDate: FormatDate.getDate(),
                                  );
                                }),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              FlatButton(
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: Text('Title'),
                            onPressed: () {
                              Provider.of<PreferencesData>(context, listen: false).safeSortPreferences('title');
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text('Edition date'),
                            onPressed: () {
                              Provider.of<PreferencesData>(context, listen: false).safeSortPreferences('updateDate DESC');
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoActionSheetAction(
                            child: Text('Creation date'),
                            onPressed: () {
                              Provider.of<PreferencesData>(context, listen: false).safeSortPreferences('createDate DESC');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
                child: FutureBuilder<String>(
                  future: Provider.of<PreferencesData>(context).getStringForSortButton(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data,
                        style: TextStyle(
                          fontSize:  SizeConfig.textMultiplier * 1.7,
                          color: Color(0xFFAAA8B4),
                        ),
                      );
                    }
                    else {
                      return Text('');
                    }
                  },
                ),
                padding: EdgeInsets.only(left: 0.0),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.3),
            child: FutureBuilder<Map>(
              future: Provider.of<PreferencesData>(context).getViewDetail(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data['viewData'];
                } else {
                  return Center(
                    child: Center(
                        child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: SizeConfig.heightMultiplier * 3.5,
          child: Center(
            child: FutureBuilder(
              future: Provider.of<NotesData>(context).getNumberOfNotes,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 1) {
                    return NumberOfNotesText(number: snapshot.data, notes: 'note');
                  }
                  else {
                    return NumberOfNotesText(number: snapshot.data, notes: 'notes');
                  }
                }
                else {
                  return Text(
                    '',
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
