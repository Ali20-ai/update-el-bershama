import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.withColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/items.png',width: 250,),
            SizedBox(height: 40,),
            Text('مرحبا بك في البرشامة',style: StylesManger.black50Bold,),
            Text('تذكير بمواعيد الادوية ,متابعة الجرعات \n           تنظيم ادويتك بسهولة',style: StylesManger.black18Bold,),
            SizedBox(height: 60,),
            ButtonWidget(onpress: (){
              Navigator.pushReplacementNamed(context, 'login');
            },
            
             text: 'ابدء الان',)
            
          ],
        ),
      ),
    );
  }
}