class UserModel {
  final String name;
  final String avatarUrl;
  final String donatedAmount;
  final double wallet;

  UserModel(this.name, this.avatarUrl, this.donatedAmount, this.wallet);

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      data['name'] ?? '',
      data['avatarUrl'] ?? '',
      data['donatedAmount'] ?? '',
      (data['wallet'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
