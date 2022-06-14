class UserResponse {
  UserResponse({
    required this.user,
  });

  User user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        user: User.fromJson(json["user"]),
      );
}

class User {
  User({
    required this.name,
    required this.email,
    this.phone,
    required this.accountNumber,
    this.profilePicture,
    required this.status,
  });

  String name;
  String email;
  String? phone;
  String accountNumber;
  String? profilePicture;
  String status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        accountNumber: json["account_number"],
        profilePicture: json["profile_picture"],
        status: json["status"],
      );
}
