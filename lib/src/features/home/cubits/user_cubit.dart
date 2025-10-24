import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCubit extends Cubit<UserModel?> {
  UserCubit() : super(null);

  Future<void> fetchUser() async {
    var userDoc = await FirebaseFirestore.instance.collection('users').doc('USER_ID').get();
    emit(UserModel.fromFirestore(userDoc.data() as Map<String, dynamic>));
  }
}
