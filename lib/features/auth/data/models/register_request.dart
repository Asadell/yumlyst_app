class RegisterRequest {
  RegisterRequest({
    required this.email,
    required this.password,
    required this.username,
  });

  final String email;
  final String password;
  final String username;

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      email: json["email"],
      password: json["password"],
      username: json["username"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": username,
      };
}
