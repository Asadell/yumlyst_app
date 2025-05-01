class LoginRequest {
  LoginRequest({
    required this.identifier,
    required this.password,
  });

  final String identifier;
  final String password;

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      identifier: json["identifier"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "password": password,
      };
}
