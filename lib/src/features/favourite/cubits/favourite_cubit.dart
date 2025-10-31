import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charity/src/features/home/models/campaign_model.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<CampaignModel> campaigns;
  FavouriteLoaded(this.campaigns);
}

class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError(this.message);
}

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  Future<void> loadFavourites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(FavouriteLoaded([]));
      return;
    }

    emit(FavouriteLoading());
    try {
      final favsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favourites')
          .get();

      if (favsSnapshot.docs.isEmpty) {
        emit(FavouriteLoaded([]));
        return;
      }

      // Get campaigns directly from favourites collection
      final campaigns = favsSnapshot.docs
          .map((doc) => CampaignModel.fromFirestore(doc.data()))
          .toList();

      emit(FavouriteLoaded(campaigns));
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> toggleFavourite(CampaignModel campaign, String? campaignDocId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Use campaign title as document ID if docId is null
      final docId = campaignDocId ?? campaign.title.hashCode.toString();
      
      final favRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favourites')
          .doc(docId);

      final favDoc = await favRef.get();
      
      if (favDoc.exists) {
        await favRef.delete();
      } else {
        // First get the campaign document to save its data
        final campaignData = {
          'title': campaign.title,
          'organization': campaign.organization,
          'progress': campaign.progress,
          'donatedAmount': campaign.donatedAmount,
          'amount': campaign.amount,
          'category': campaign.category,
          'location': campaign.location,
          'imageUrl': campaign.imageUrl,
          'imageUrl1': campaign.imageUrl1,
          'story': campaign.story,
          'period': campaign.period,
          'addedAt': FieldValue.serverTimestamp(),
        };
        
        await favRef.set(campaignData);
      }

      // Reload favourites
      await loadFavourites();
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<bool> isFavourite(CampaignModel campaign, String? campaignDocId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;

    try {
      final docId = campaignDocId ?? campaign.title.hashCode.toString();
      final favDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favourites')
          .doc(docId)
          .get();

      return favDoc.exists;
    } catch (e) {
      return false;
    }
  }
}

