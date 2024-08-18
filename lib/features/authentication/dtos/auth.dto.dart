class AuthDto {
  final String email;
  final String pass;
  AuthDto({
    required this.email,
    required this.pass,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': pass,
    };
  }
}
