import 'get_user_data_response.dart';

class RegisterResponse {
  const RegisterResponse({
    required this.status,
    required this.user,
    required this.token,
    required this.message,
  });
  final bool status;
  final UserDataResponse user;
  final String token;
  final String message;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
        status: json['status'],
        user: UserDataResponse.fromJson(json['user']),
        token: json['token'],
        message: json['message']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['user'] = user.toJson();
    _data['token'] = token;
    _data['message'] = message;
    return _data;
  }
}