class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;
  final int donatedAmount;
  final int wallet;

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
    return UserModel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      donatedAmount: map['donatedAmount'] ?? 0,
      wallet: map['wallet'] ?? 0,
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
