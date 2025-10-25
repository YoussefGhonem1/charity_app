import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/foundation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoundationCubit extends Cubit<List<FoundationModel>> {
  FoundationCubit() : super([]);

  void getFoundations() async {
    final snapshot = await FirebaseFirestore.instance.collection('foundations').get();
    emit(snapshot.docs.map((doc) => FoundationModel.fromJson(doc.data())).toList());
  }
}
