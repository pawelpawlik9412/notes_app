import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class SizeConfig {


  static double _screenWidth;
  static double _screenHeight;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static double textMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool portraitOrientation = true;
  static bool _smallScreen = false;


  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      portraitOrientation = true;
      if (constraints.maxWidth < 450.0) {
        _smallScreen = true;
      }
      else {
        _smallScreen = false;
      }
    }
    else if (orientation == Orientation.landscape) {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      portraitOrientation = false;
      if (constraints.maxHeight < 450.0) {
        _smallScreen = true;
      }
      else {
        _smallScreen = false;
      }
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;
    textMultiplier = _blockHeight;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }

  get screenSize {
    if (_smallScreen == true) {
      return true;
    } else {
      return false;
    }
  }



}


