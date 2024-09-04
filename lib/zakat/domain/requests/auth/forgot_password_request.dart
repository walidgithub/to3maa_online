import 'package:equatable/equatable.dart';

class ForgotPassRequest extends Equatable {
  ForgotPassRequest({
    required this.email,
    required this.verifyCode,
  });
  late final String email;
  late final String verifyCode;

  ForgotPassRequest.fromJson(Map<String, dynamic> json){
    email = json['email'];
    verifyCode = json['verify_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['verify_code'] = verifyCode;
    return _data;
  }

  @override
  List<Object?> get props => [email, verifyCode];
}
