import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref {

  SharedPref({@required this.instanceName, @required this.deflautValue});

  String instanceName;
  String deflautValue;

  read() async {
    final prefs = await SharedPreferences.getInstance();
    var x = prefs.getString(instanceName);
    if (x == null) {
      return deflautValue;
    }
    return x;
  }

  save(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(instanceName, value);
  }

  remove() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(instanceName);
  }
}