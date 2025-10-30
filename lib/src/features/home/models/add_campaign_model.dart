class AddCampaignModel{

 final String photo;
  final String title;
  final String location;
  final String? story;
  final double  requiredAmount;
  final String? collectionPeriod;

  AddCampaignModel({required this.photo, required this.title, required this.location, required this.story, required this.requiredAmount, required this.collectionPeriod});


factory AddCampaignModel.fromFirestore(Map<String, dynamic> data) {
  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

return AddCampaignModel(

photo:data['photo'] ?? "" ,   
 title: data['title'] ?? '',
location: data["location"]??"",
story: data["story"]??"",
 requiredAmount: data['requiredAmount'] ?? '',
 collectionPeriod: data['collectionPeriod'] ?? '',

);


}

}




























