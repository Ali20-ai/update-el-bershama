import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:flutter/material.dart';

class StylesManger {

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleText20Style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle titleText21Style = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ColorsManger.withColor,
  );
  static const TextStyle titleText18StylePrimry = TextStyle(
    fontSize: 20,
    color: ColorsManger.withColor,
  );

  static TextStyle white50Bold = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle black50Bold = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static TextStyle black18Bold = TextStyle(
    fontSize: 18,
    
    color: Colors.black,
  );
  static TextStyle white20Bold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle white14 = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );


}