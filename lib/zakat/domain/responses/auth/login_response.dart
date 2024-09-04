import 'get_user_data_response.dart';

class LoginResponse {
  const LoginResponse({
    required this.status,
    required this.user,
    required this.token,
    required this.message,
  });

  final bool status;
  final UserDataResponse user;
  final String token;
  final String message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
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
