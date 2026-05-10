import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onpress;
  final String text;
  const ButtonWidget({super.key, required this.onpress, required this.text});

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      
      width: width * 0.9,
      height: height * 0.065,
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff2054BB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(text, style: StylesManger.white20Bold),
      ),
    
    );
  }
}