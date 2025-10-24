import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/campaign_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CampaignsCubit extends Cubit<List<CampaignModel>> {
  CampaignsCubit() : super([]);

  Future<void> fetchCampaigns() async {
    var snapshot = await FirebaseFirestore.instance.collection('campaigns').get();
    emit(snapshot.docs.map((doc) => CampaignModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList());
  }
}
