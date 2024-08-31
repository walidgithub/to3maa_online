import 'package:equatable/equatable.dart';

class ZakatResponse extends Equatable {
  ZakatResponse({
    required this.id,
    required this.userId,
    required this.membersCount,
    required this.zakatValue,
    required this.remainValue,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final int membersCount;
  late final String zakatValue;
  late final String remainValue;
  late final String createdAt;
  late final String updatedAt;

  ZakatResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    membersCount = json['membersCount'];
    zakatValue = json['zakatValue'];
    remainValue = json['remainValue'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['membersCount'] = membersCount;
    _data['zakatValue'] = zakatValue;
    _data['remainValue'] = remainValue;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }

  @override
  List<Object?> get props => [id, membersCount, zakatValue, remainValue];
}
