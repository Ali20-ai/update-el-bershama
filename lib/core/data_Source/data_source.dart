import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_bershama/features/auth/cubit/models/models.dart';
import 'package:el_bershama/features/models/personal/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // تسجيل الدخول
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // إنشاء حساب
  Future<void> signUp(String email, String password, String name) async {
    // إنشاء الحساب في Firebase Auth
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(
          Usres(
            email: email,
            password: '', 
            name: name,
          ).toMap(),
        );
  }



Future<void> addMedicine(Medicine medicine) async {
    await _firestore.collection('medicines').add(medicine.toMap());


    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .add({
      'name': medicine.name,
      'doseCount': medicine.doseCount,
      'times': medicine.times,
      'startDate': medicine.startDate.toIso8601String(),
      'endDate': medicine.endDate?.toIso8601String(),
      'image': medicine.image,
    });
  }

  
  Future<List<Medicine>> getMedicines() async {
    final snapshot = await _firestore.collection('medicines').get();
    return snapshot.docs.map((doc) {
      return Medicine.fromMap(doc.data());
    }).toList();
  }
}
