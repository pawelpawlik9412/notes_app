import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_app/size_config.dart';
import 'package:notes_app/model/format_date.dart';
import 'package:notes_app/providers/notes_data.dart';
import 'package:notes_app/model/note.dart';
import 'package:provider/provider.dart';


class DetailScreen extends StatefulWidget {

  DetailScreen({
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
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {





  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();


  @override
  void initState() {
    super.initState();
    titleTextEditingController.text = widget.title;
    contentTextEditingController.text = widget.content;
  }

  void checkIfExist() {
    String title = titleTextEditingController.text.trim();
    String content = contentTextEditingController.text.trim();
    if (widget.id == null) {
      if (title == '' && content == '') {
        return;
      }
      else {
        Provider.of<NotesData>(context, listen: false).addNote(
          Note(
            title: titleTextEditingController.text,
            content: contentTextEditingController.text,
            createDate: FormatDate.getDate(),
            updateDate: FormatDate.getDate(),
          ),
        );
      }
    } else {
      Provider.of<NotesData>(context, listen: false).updateNote(
        widget.id,
        titleTextEditingController.text,
        contentTextEditingController.text,
        FormatDate.getDate(),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 2, left: SizeConfig.widthMultiplier * 2, right: SizeConfig.widthMultiplier * 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      checkIfExist();
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.back,
                      color: Colors.black,
                      size: SizeConfig.heightMultiplier * 3.5,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          checkIfExist();
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.save_alt,
                          size: SizeConfig.heightMultiplier * 3.5,
                          color: Color(0xFFC6D7E5),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<NotesData>(context, listen: false).deleteNote(widget.id,context);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          size: SizeConfig.heightMultiplier * 3.5,
                          color: Color(0xFFC6D7E5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.heightMultiplier * 3,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4, right: SizeConfig.widthMultiplier * 4),
                child: ListView(
                  children: <Widget>[
                    TextField(
                      maxLines: null,
                      controller: titleTextEditingController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 4,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Text(
                      FormatDate.labelDateFormat(widget.createDate),
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 1.5,
                      ),
                    ),
                    TextField(
                      maxLines: null,
                      controller: contentTextEditingController,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
