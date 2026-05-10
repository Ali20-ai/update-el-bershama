import 'package:el_bershama/core/style/colors_manger.dart';
import 'package:el_bershama/core/style/styles_manger.dart';
import 'package:el_bershama/core/widgets/button_widget.dart';
import 'package:el_bershama/features/auth/cubit/home/home_cubit.dart';
import 'package:el_bershama/features/auth/cubit/home/state_manger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorsManger.withColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset('images/part bershama.png', width: 120),
                Text(
                  'تسجيل الدخول',
                  style: StylesManger.black50Bold,
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  hint: 'البريد الالكتروني',
                  icon: Icons.email,
                  controller: emailController,
                ),
                CustomTextField(
                  hint: 'كلمة المرور',
                  icon: Icons.lock,
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 20),
                BlocConsumer<HomeCubit, StateManger>(
                  listener: (context, state) {
                    if (state is LoginSuccessStates) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Login success'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pushReplacementNamed(context, 'Home');
                    }

                    if (state is LoginErrorStates) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message), // أو state.error حسب ملفك
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    final cubit = context.read<HomeCubit>();

                    if (state is LoginLoadingStates) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
                      children: [
                        ButtonWidget(
                          onpress: () {
                            cubit.tologin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                          text: "تسجيل الدخول",
                        ),
                        const SizedBox(height: 20),
                        const Text('______________ أو ________________'),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (kDebugMode) {
                                  print('login');
                                }
                                Navigator.pushNamed(context, 'singUp');
                              },
                              child: Text(
                                'انشاء حساب',
                                style: StylesManger.titleText20Style,
                              ),
                            ),
                            Text(
                              'ليس لديك حساب ؟ ',
                              style: StylesManger.titleText20Style,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
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
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}