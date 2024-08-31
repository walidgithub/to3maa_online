import 'package:equatable/equatable.dart';

class ZakatProductsByKilosResponse extends Equatable {
  ZakatProductsByKilosResponse({
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productImage,
    required this.sa3Weight,
    required this.productTotals,
  });
  late final String productName;
  late final String productPrice;
  late final String productDesc;
  late final String productImage;
  late final int sa3Weight;
  late final int productTotals;

  ZakatProductsByKilosResponse.fromJson(Map<String, dynamic> json){
    productName = json['productName'];
    productPrice = json['productPrice'];
    productDesc = json['productDesc'];
    productImage = json['productImage'];
    sa3Weight = json['sa3Weight'];
    productTotals = json['productTotals'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productName'] = productName;
    _data['productPrice'] = productPrice;
    _data['productDesc'] = productDesc;
    _data['productImage'] = productImage;
    _data['sa3Weight'] = sa3Weight;
    _data['productTotals'] = productTotals;
    return _data;
  }

  @override
  List<Object?> get props => [
        productName,
        productPrice,
        productDesc,
        productImage,
        sa3Weight
      ];
}
