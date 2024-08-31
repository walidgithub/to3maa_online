import 'package:equatable/equatable.dart';

class ProductsResponse extends Equatable {
  ProductsResponse({
    required this.id,
    required this.userId,
    required this.productName,
    required this.productPrice,
    required this.productDesc,
    required this.productImage,
    required this.productQuantity,
    required this.sa3Weight,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final String productName;
  late final String productPrice;
  late final String productDesc;
  late final String productImage;
  late final int productQuantity;
  late final int sa3Weight;
  late final String createdAt;
  late final String updatedAt;

  ProductsResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productDesc = json['productDesc'];
    productImage = json['productImage'];
    productQuantity = json['productQuantity'];
    sa3Weight = json['sa3Weight'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['productName'] = productName;
    _data['productPrice'] = productPrice;
    _data['productDesc'] = productDesc;
    _data['productImage'] = productImage;
    _data['productQuantity'] = productQuantity;
    _data['sa3Weight'] = sa3Weight;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }

  @override
  List<Object?> get props => [
        id,
        productName,
        productPrice,
        productDesc,
        productImage,
        sa3Weight,
        productQuantity
      ];
}
