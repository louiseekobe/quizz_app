import 'package:flutter/material.dart';

class TestUtil extends Text{
  TestUtil(String text, {color:Colors.white, textScaleFactor : 1.5}):
      super(
        text,
        textScaleFactor: textScaleFactor,
        textAlign: TextAlign.center,
        style: new TextStyle(color: color)
      );
}