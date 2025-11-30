class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;
  final double donatedAmount;
  final double wallet;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl,
    required this.donatedAmount,
    required this.wallet,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    double toDouble(dynamic value) {
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      donatedAmount: toDouble(map['donatedAmount']),
      wallet: toDouble(map['wallet']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'avatarUrl': avatarUrl,
      'donatedAmount': donatedAmount,
      'wallet': wallet,
    };
  }
}
