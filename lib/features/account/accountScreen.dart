import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:el_bershama/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  bool isNotificationOn = true;
  bool isDarkMode = false;

  void goHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManger.withColor,
      appBar: AppBar(
        backgroundColor: ColorsManger.primaryColor,
        title: Text(
          "الحساب",
          style: StylesManger.titleText21Style,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: ColorsManger.withColor,
          ),
          onPressed: () => goHome(context),
        ),
      ),
      
      

      body:
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
         
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
         
                Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: ColorsManger.primaryColor,
                    ),
                    SizedBox(width: 10),
         
                    Text('الاعدادات'),
                  ],
                ),
         
              ],
            ),
         
            SizedBox(height: 20),
         
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
         
                Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: ColorsManger.primaryColor,
                    ),
         
                    SizedBox(width: 10),
         
                    Text('الاشعارات'),
                  ],
                ),
                SizedBox(height: 20),
         
                Switch(
                  value: isNotificationOn,
                  activeColor: ColorsManger.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      isNotificationOn = value;
                    });
                  },
                ),
         
              ],
              
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
         
                Row(
                  children: [
                    Icon(
                      Icons.nightlight,
                      color: ColorsManger.primaryColor,
                    ),
         
                    SizedBox(width: 10),
         
                    Text('الوضع الليلي'),
                  ],
                ),
         
                Switch(
                  value: isDarkMode,
                  activeColor: ColorsManger.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
         
              ],
            
            ),SizedBox(height: 20),
         
            Row(
              children: [
                Icon(Icons.person,color: ColorsManger.primaryColor,),
                SizedBox(width: 10),
                Text('اداره الحساب ')
              ],
            ),SizedBox(height: 20),
         
         
            Row(
              children: [
                Icon(Icons.edit,color: ColorsManger.primaryColor,),
                SizedBox(width: 10),
                Text('تعديل البيانات'),
                SizedBox(width: 230),
                
               IconButton(onPressed: (){

               }, icon: Icon(Icons.arrow_forward_ios_outlined))
              ],
            ),
            SizedBox(height: 300,),
            ButtonWidget(onpress: (){
              Navigator.pushReplacementNamed(context, 'login');
            }, 
            text: 'تسجيل الخروج')
          ],
              
               ),
       ),
    );
  }
}