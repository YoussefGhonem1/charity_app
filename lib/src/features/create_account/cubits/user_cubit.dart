import 'package:charity/src/features/create_account/models/users_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  Future<void> loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      emit(UserModel.fromMap({
        'uid': uid,
        ...doc.data()!,
      }));
    }
  }

  void setUser(UserModel user) {
    emit(user);
  }

  // تسجيل خروج
  void clearUser() {
    emit(null);
  }
}
