import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_app/size_config.dart';
import 'package:notes_app/screens/detail_screen.dart';
import 'detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/providers/notes_data.dart';
import 'package:notes_app/model/format_date.dart';



class DetailScreenView extends StatelessWidget  {

  DetailScreenView({@required this.id, @required this.title, @required this.content, @required this.createDate, @required this.updateDate});

  int id;
  String title;
  String content;
  String createDate;
  String updateDate;


  var x = SizeConfig.textMultiplier * 3;
  var y = SizeConfig.textMultiplier * 2;

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 5, right:  SizeConfig.heightMultiplier * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
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
                  icon: Icon(
                    Icons.fullscreen,
                    size: SizeConfig.heightMultiplier * 3,
                    color: Color(0xFFC6D7E5),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<NotesData>(context, listen: false).deleteNote(id, context);
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    size: SizeConfig.heightMultiplier * 3,
                    color: Color(0xFFC6D7E5),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 1.5, right: SizeConfig.widthMultiplier * 1.5),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 5,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Text(
                    FormatDate.labelDateFormat(createDate),
                    style: TextStyle(
                      fontSize: SizeConfig.heightMultiplier * 1.5,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Text(
                    content,
                    style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }
}
