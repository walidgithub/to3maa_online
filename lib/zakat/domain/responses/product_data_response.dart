class ProductDataResponse {
  const ProductDataResponse({
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
  final int id;
  final int userId;
  final String productName;
  final String productPrice;
  final String productDesc;
  final String productImage;
  final int productQuantity;
  final int sa3Weight;
  final String createdAt;
  final String updatedAt;

  factory ProductDataResponse.fromJson(Map<String, dynamic> json) {
    return ProductDataResponse(
        id: json['id'],
        userId: json['user_id'],
        productName: json['productName'],
        productPrice: json['productPrice'],
        productDesc: json['productDesc'],
        productImage: json['productImage'],
        productQuantity: json['productQuantity'],
        sa3Weight: json['sa3Weight'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
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
}
