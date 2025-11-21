import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/campaign_model.dart';

abstract class CampaignsState {}
class CampaignsInitial extends CampaignsState {}
class CampaignsLoading extends CampaignsState {}
class CampaignsLoaded extends CampaignsState {
  final List<CampaignModel> campaigns;
  CampaignsLoaded(this.campaigns);
}
class CampaignsError extends CampaignsState {
  final String message;
  CampaignsError(this.message);
}

class CampaignsCubit extends Cubit<CampaignsState> {
  List<CampaignModel> _cachedCampaigns = [];

  CampaignsCubit() : super(CampaignsInitial());

Future<void> fetchCampaigns() async {
    emit(CampaignsLoading());
    try {
      var snapshot = await FirebaseFirestore.instance.collection('campaigns').get();
      var campaigns = snapshot.docs
          .map((doc) => CampaignModel.fromFirestore(doc.id, doc.data())) 
          .toList();
      _cachedCampaigns = campaigns;
      emit(CampaignsLoaded(campaigns));
    } catch (e) {
      emit(CampaignsError(e.toString()));
    }
  }

  void filterCampaigns(String query) {
    if (query.isEmpty) {
      emit(CampaignsLoaded(_cachedCampaigns));
    } else {
      final filtered = _cachedCampaigns
          .where((c) => c.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(CampaignsLoaded(filtered));
    }
  }
}
