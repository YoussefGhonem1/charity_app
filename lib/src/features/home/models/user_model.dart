class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String donatedAmount;
  final double walletBalance;
  final bool donateAsAnonymous;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.donatedAmount,
    required this.walletBalance,
    this.donateAsAnonymous = false,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? donatedAmount,
    double? walletBalance,
    bool? donateAsAnonymous,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      donatedAmount: donatedAmount ?? this.donatedAmount,
      walletBalance: walletBalance ?? this.walletBalance,
      donateAsAnonymous: donateAsAnonymous ?? this.donateAsAnonymous,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'donatedAmount': donatedAmount,
      'walletBalance': walletBalance,
      'donateAsAnonymous': donateAsAnonymous,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      donatedAmount: json['donatedAmount'] ?? '0',
      walletBalance: (json['walletBalance'] ?? 0.0).toDouble(),
      donateAsAnonymous: json['donateAsAnonymous'] ?? false,
    );
  }
}
