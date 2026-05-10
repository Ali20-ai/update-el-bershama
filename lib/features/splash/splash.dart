import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

@override
 
  void initState(){
    Future.delayed(Duration(seconds: 5),(){
      Navigator.pushReplacementNamed(context, 'start');
    });
    super.initState(); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/bersham.png',width: 150,),
            Text('البرشامة',style:  StylesManger.white50Bold),
            Text('دوائك...في وقتك',style: StylesManger.titleText18StylePrimry,)
          ],
        ),
      ),
    );
    
  }
}