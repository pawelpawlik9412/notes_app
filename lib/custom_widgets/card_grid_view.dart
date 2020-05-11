import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/size_config.dart';
import 'package:notes_app/model/format_date.dart';
import 'package:notes_app/screens/detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/notes_data.dart';

class CardGridView extends StatelessWidget {

  CardGridView({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.createDate,
    @required this.updateDate,
  });

  final int id;
  final String title;
  final String content;
  final String createDate;
  final String updateDate;

  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: <Widget>[
        CupertinoContextMenuAction(
          child: Text('Open'),
          trailingIcon: CupertinoIcons.pencil,
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailScreen(
                    id: id,
                    title: title,
                    content: content,
                    createDate: createDate,
                    updateDate: updateDate,
                  );
                },
              ),
            );
          },
        ),
        CupertinoContextMenuAction(
          child: Text('Delete',
            style: TextStyle(
                color: CupertinoColors.destructiveRed
            ),
          ),
          trailingIcon: CupertinoIcons.delete,
          onPressed: () {
            Provider.of<NotesData>(context, listen: false).deleteNote(id, context);
            Navigator.pop(context);
          },
        ),
      ],
      child: GestureDetector(
        onTap: () {
          if (SizeConfig().screenSize == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DetailScreen(
                    id: id,
                    title: title,
                    content: content,
                    createDate: createDate,
                    updateDate: updateDate,
                  );
                },
              ),
            );
          }
          else {
            Provider.of<NotesData>(context, listen: false).setSelectedNote(id);
          }
        },
        child: Material(
          borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 3),
          child: Container(
            constraints: BoxConstraints(maxHeight: SizeConfig.heightMultiplier * 27.0, minWidth: SizeConfig.widthMultiplier * 98, maxWidth: SizeConfig.widthMultiplier * 98),
            margin: EdgeInsets.all(SizeConfig.heightMultiplier * 1.0),
            decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: EdgeInsets.all(SizeConfig.widthMultiplier * 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.heightMultiplier * 0.2,
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF3C424A),
                    fontSize: SizeConfig.textMultiplier * 2.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 0.7,
                ),
                Text(
                  FormatDate.labelDateFormat(createDate),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFF3C424A),
                    fontSize: SizeConfig.textMultiplier * 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 1.7,
                ),
                Text(
                  content,
                  textAlign: TextAlign.left,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize:  SizeConfig.textMultiplier * 1.8,
                    color: Color(0xFF3C424A),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
