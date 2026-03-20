import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../domain/entities/user.dart';
import '../../domain/entities/user_status.dart';
import '../../domain/usecases/register_params.dart';

class AuthFirebaseDataSource {
  final fb.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthFirebaseDataSource({
    fb.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? fb.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  Future<fb.User> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!;
  }

  Future<fb.User> register(RegisterParams params) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    final fbUser = credential.user!;
    await fbUser.updateDisplayName(params.fullName);

    // Save user profile to Firestore
    await _usersCollection.doc(fbUser.uid).set({
      'fullName': params.fullName,
      'email': params.email,
      'status': params.status.name,
      'universityId': params.universityId,
      'departmentId': params.departmentId,
      'grade': params.grade,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return fbUser;
  }

  Future<User> getUserProfile(String uid) async {
    final doc = await _usersCollection.doc(uid).get();
    final data = doc.data();

    if (data == null) {
      throw Exception('Kullanıcı profili bulunamadı');
    }

    return User(
      id: uid,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      status: UserStatus.values.firstWhere(
        (s) => s.name == data['status'],
        orElse: () => UserStatus.highSchool,
      ),
      universityName: data['universityName'],
      departmentName: data['departmentName'],
      grade: data['grade'],
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  bool isLoggedIn() => _auth.currentUser != null;

  fb.User? get currentUser => _auth.currentUser;

  Stream<fb.User?> get authStateChanges => _auth.authStateChanges();

  static String firebaseErrorToTurkish(String code) {
    return switch (code) {
      'user-not-found' => 'Bu e-posta ile kayıtlı kullanıcı bulunamadı',
      'wrong-password' => 'Şifre hatalı',
      'invalid-credential' => 'E-posta veya şifre hatalı',
      'email-already-in-use' => 'Bu e-posta zaten kullanılıyor',
      'weak-password' => 'Şifre çok zayıf, en az 6 karakter olmalı',
      'invalid-email' => 'Geçersiz e-posta adresi',
      'too-many-requests' => 'Çok fazla deneme yaptınız, lütfen bekleyin',
      'user-disabled' => 'Bu hesap devre dışı bırakılmış',
      'operation-not-allowed' => 'Bu işleme izin verilmiyor',
      'network-request-failed' => 'İnternet bağlantınızı kontrol edin',
      _ => 'Bir hata oluştu, lütfen tekrar deneyin',
    };
  }
}
