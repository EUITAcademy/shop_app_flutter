class AuthData {
  const AuthData({
    required this.token,
    required this.exp,
  });

  final String token;
  final String exp;

  AuthData.fromJson(Map<String, dynamic> json)
      : token = json['token'] as String,
        exp = json['exp'] as String;
}
