import 'package:flutter/material.dart';
import 'package:notes_app/size_config.dart';

class NumberOfNotesText extends StatelessWidget {

  NumberOfNotesText({@required this.number, @required this.notes});

  final int number;
  final String notes;


  @override
  Widget build(BuildContext context) {
    return Text(
      '$number  $notes',
      style:  TextStyle(
        fontSize: SizeConfig.textMultiplier * 2,
        color: Color(0xFFAAA8B4),
      ),
    );
  }
}
