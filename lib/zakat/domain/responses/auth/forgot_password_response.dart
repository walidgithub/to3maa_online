import 'package:To3maa/zakat/domain/responses/auth/get_user_data_response.dart';

class ForgotPasswordResponse {
  const ForgotPasswordResponse({
    required this.status,
    required this.user,
    required this.message,
  });
  final bool status;
  final UserDataResponse user;
  final String message;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(
        status: json['status'],
        user: UserDataResponse.fromJson(json['user']),
        message: json['message']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = user.toJson();
    _data['message'] = message;
    return _data;
  }
}