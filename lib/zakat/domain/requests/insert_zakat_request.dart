import 'package:equatable/equatable.dart';

import 'insert_zakat_products_request.dart';

class InsertZakatRequest extends Equatable {
  InsertZakatRequest({
    required this.membersCount,
    required this.zakatValue,
    required this.remainValue,
    required this.zakatProducts,
  });
  late final int membersCount;
  late final String zakatValue;
  late final String remainValue;
  late final List<InsertZakatProductsRequest> zakatProducts;

  InsertZakatRequest.fromJson(Map<String, dynamic> json){
    membersCount = json['membersCount'];
    zakatValue = json['zakatValue'];
    remainValue = json['remainValue'];
    zakatProducts = List.from(json['zakatProducts']).map((e)=>InsertZakatProductsRequest.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['membersCount'] = membersCount;
    _data['zakatValue'] = zakatValue;
    _data['remainValue'] = remainValue;
    _data['zakatProducts'] = zakatProducts.map((e)=>e.toJson()).toList();
    return _data;
  }

  @override
  List<Object?> get props => [membersCount, zakatValue, remainValue, zakatProducts];
}
