import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/foundation_model.dart';

abstract class FoundationsState {}

class FoundationsInitial extends FoundationsState {}

class FoundationsLoading extends FoundationsState {}

class FoundationsLoaded extends FoundationsState {
  final List<FoundationModel> foundations;
  FoundationsLoaded(this.foundations);
}

class FoundationsError extends FoundationsState {
  final String message;
  FoundationsError(this.message);
}

class FoundationCubit extends Cubit<FoundationsState> {
  FoundationCubit() : super(FoundationsInitial());

  Future<void> fetchFoundations() async {
    emit(FoundationsLoading());
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('foundations')
          .get();
   final foundationsList = snapshot.docs.map((doc) {
  final rawData = doc.data() as Map<String, dynamic>;
  print("Raw data from Firestore: $rawData");
  
  final foundation = FoundationModel.fromJson(rawData);
  print("Foundation fetched: ${foundation.title}, ${foundation.organization}, ${foundation.imageUrl}");
  
  return foundation;
}).toList();


      emit(FoundationsLoaded(foundationsList));
    } catch (e) {
      print("Error fetching foundations: $e");
      emit(FoundationsError(e.toString()));
    }
  }
}
