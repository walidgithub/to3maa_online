class RegisterRequest {
  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.verifyCode,
  });
  late final String name;
  late final String email;
  late final String password;
  late final String passwordConfirmation;
  late final String verifyCode;

  RegisterRequest.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    verifyCode = json['verify_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['password_confirmation'] = passwordConfirmation;
    _data['verify_code'] = verifyCode;
    return _data;
  }
}