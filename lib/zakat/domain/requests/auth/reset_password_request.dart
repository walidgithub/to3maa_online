import 'package:equatable/equatable.dart';

class ResetPassRequest extends Equatable {
  ResetPassRequest({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });
  late final String email;
  late final String password;
  late final String passwordConfirmation;

  ResetPassRequest.fromJson(Map<String, dynamic> json){
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    _data['password_confirmation'] = passwordConfirmation;
    return _data;
  }

  @override
  List<Object?> get props => [email, password, passwordConfirmation];
}
