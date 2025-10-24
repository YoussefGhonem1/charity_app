class UserModel {
  final String name;
  final String avatarUrl;
  final String donatedAmount;

  UserModel(this.name, this.avatarUrl, this.donatedAmount);

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      data['name'] ?? '',
      data['avatarUrl'] ?? '',
      data['donatedAmount'] ?? '',
    );
  }
}
