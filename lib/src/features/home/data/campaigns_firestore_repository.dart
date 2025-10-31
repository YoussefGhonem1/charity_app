import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/campaign_model.dart';

class CampaignsFirestoreRepository {
  CampaignsFirestoreRepository._();
  static final CampaignsFirestoreRepository instance = CampaignsFirestoreRepository._();

  final CollectionReference<Map<String, dynamic>> _featured = FirebaseFirestore.instance.collection('campaigns').doc('featured').collection('items');
  final CollectionReference<Map<String, dynamic>> _latest = FirebaseFirestore.instance.collection('campaigns').doc('latest').collection('items');

  Stream<List<CampaignModel>> featuredCampaignsStream() {
    return _featured.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return CampaignModel(
          data['title'] ?? '',
          data['by'] ?? '',
          (data['percent'] ?? 0.0).toDouble(),
          data['donors'] ?? 0,
          data['category'] ?? '',
          data['location'] ?? '',
          data['image'] ?? '',
        );
      }).toList();
    });
  }

  Stream<List<CampaignModel>> latestCampaignsStream() {
    return _latest.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return CampaignModel(
          data['title'] ?? '',
          data['by'] ?? '',
          (data['percent'] ?? 0.0).toDouble(),
          data['donors'] ?? 0,
          data['category'] ?? '',
          data['location'] ?? '',
          data['image'] ?? '',
        );
      }).toList();
    });
  }

  Future<void> addFeaturedCampaign(CampaignModel campaign) async {
    await _featured.add({
      'title': campaign.title,
      'by': campaign.by,
      'percent': campaign.percent,
      'donors': campaign.donors,
      'category': campaign.category,
      'location': campaign.location,
      'image': campaign.image,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addLatestCampaign(CampaignModel campaign) async {
    await _latest.add({
      'title': campaign.title,
      'by': campaign.by,
      'percent': campaign.percent,
      'donors': campaign.donors,
      'category': campaign.category,
      'location': campaign.location,
      'image': campaign.image,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> seedInitialData() async {
    // Only add if collections are empty
    final featuredSnapshot = await _featured.limit(1).get();
    final latestSnapshot = await _latest.limit(1).get();

    if (featuredSnapshot.docs.isEmpty) {
      await _featured.add({
        'title': 'Donation for Child',
        'by': 'Unesco',
        'percent': 0.5,
        'donors': 12300,
        'category': 'Emergencies',
        'location': 'Africa / Namibia',
        'image': 'https://media.hawzahnews.com/d/2019/11/03/4/866306.jpg',
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _featured.add({
        'title': 'Help for Families',
        'by': 'Unesco',
        'percent': 0.7,
        'donors': 4530,
        'category': 'Social project',
        'location': 'Europe / France',
        'image': 'https://ofhsoupkitchen.org/wp-content/uploads/2021/02/charity-bible-verses-1-1024x683.jpg',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    if (latestSnapshot.docs.isEmpty) {
      await _latest.add({
        'title': 'Donation for Child',
        'by': 'Unesco',
        'percent': 0.5,
        'donors': 12300,
        'category': 'Emergencies',
        'location': 'Africa / Namibia',
        'image': 'https://media.hawzahnews.com/d/2019/11/03/4/866306.jpg',
        'createdAt': FieldValue.serverTimestamp(),
      });
      await _latest.add({
        'title': 'School Library Project',
        'by': 'Unesco',
        'percent': 0.7,
        'donors': 6700,
        'category': 'Education',
        'location': 'Asia / Indonesia',
        'image': 'https://ofhsoupkitchen.org/wp-content/uploads/2021/02/charity-bible-verses-1-1024x683.jpg',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }
}
