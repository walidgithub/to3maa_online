class UserDataResponse {
  const UserDataResponse({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.verifyCode,
  });
  final int id;
  final String name;
  final String email;
  final Null emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String verifyCode;

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
        id : json['id'],
        name : json['name'],
        email : json['email'],
        emailVerifiedAt : null,
        createdAt : json['created_at'],
        updatedAt : json['updated_at'],
        verifyCode : json['verify_code']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['verify_code'] = verifyCode;
    return _data;
  }
}