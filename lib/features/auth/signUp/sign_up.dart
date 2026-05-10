import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:el_bershama/features/auth/cubit/home/home_cubit.dart';
import 'package:el_bershama/features/auth/cubit/home/state_manger.dart';
import 'package:el_bershama/features/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset('images/part bershama.png'),
                  const SizedBox(height: 10),
                  Text(
                    'انشاء حساب',
                    style: StylesManger.black50Bold,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    isPassword: false,
                    hint: 'الاسم',
                    icon: Icons.person,
                    controller: nameController,
                  ),
                  CustomTextField(
                    isPassword: false,
                    hint: 'البريد',
                    icon: Icons.email,
                    controller: emailController,
                  ),
                  CustomTextField(
                    isPassword: true,
                    hint: 'كلمة المرور',
                    icon: Icons.lock,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 35),
                  BlocConsumer<HomeCubit, StateManger>(
                    listener: (context, state) {
                      if (state is SignUpSuccessStates) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم إنشاء الحساب بنجاح'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        goHome(context);
                      }

                      if (state is SignUpErrorStates) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message), // ✅ تصحيح الخطأ
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final cubit = context.read<HomeCubit>();

                      if (state is SignUpLoadingStates) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ButtonWidget(
                        onpress: () {
                          cubit.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                          );
                        },
                        text: 'انشاء حساب',
                      );
                    },
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (kDebugMode) {
                            print('login');
                          }
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Text(
                          'سجل دخولك',
                          style: StylesManger.titleText20Style,
                        ),
                      ),
                      Text(
                        'لديك حساب بالفعل ؟',
                        style: StylesManger.titleText20Style,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final bool isPassword;
  final IconData icon;
  final String hint;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.isPassword,
    required this.hint,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}