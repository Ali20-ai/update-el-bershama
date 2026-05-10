import 'package:firebase_auth/firebase_auth.dart';
import 'package:el_bershama/core/data_Source/data_source.dart';
import 'package:el_bershama/features/auth/cubit/home/state_manger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<StateManger> {
  FirebaseDataSource firebaseDataSource = FirebaseDataSource();
  HomeCubit() : super(LoginIntitalStates());

  Future<void> tologin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingStates());
    try {
      final trimmedEmail = email.trim();
      final trimmedPassword = password.trim();

      await firebaseDataSource.login(trimmedEmail, trimmedPassword);
      emit(LoginSuccessStates(''));
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorStates('${e.code} - ${e.message}'));
    } catch (e) {
      emit(LoginErrorStates('خطأ غير متوقع: $e'));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoadingStates());
    try {
      final trimmedEmail = email.trim();
      final trimmedPassword = password.trim();
      final trimmedName = name.trim();

      await firebaseDataSource.signUp(trimmedEmail, trimmedPassword, trimmedName);
      emit(SignUpSuccessStates(''));
    } on FirebaseAuthException catch (e) {
      // ✅ التعديل: عرض الكود والرسالة الأصليين من Firebase
      emit(SignUpErrorStates('${e.code} - ${e.message}'));
    } catch (e) {
      emit(SignUpErrorStates('خطأ غير متوقع: $e'));
    }
  }
}