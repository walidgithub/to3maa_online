import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/get_product_data_request.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/domain/responses/product_data_response.dart';
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_manager.dart';
import '../../domain/requests/auth/login_request.dart';
import '../../domain/requests/auth/register_request.dart';

abstract class BaseDataSource {
  Future<void> register(RegisterRequest registerRequest);

  Future<void> login(LoginRequest loginRequest);

  Future<void> logout();

  Future<void> insertZakatData(InsertZakatRequest insertZakatRequest);

  Future<void> insertProductData(InsertProductRequest insertProductRequest);

  Future<void> updateProductData(UpdateProductRequest updateProductRequest);

  Future<void> deleteZakatData(DeleteZakatRequest deleteZakatRequest);

  Future<void> deleteAllZakatData();

  Future<void> deleteProductData(DeleteProductRequest deleteProductRequest);

  Future<List<ProductsResponse>> getAllProducts();

  Future<List<ZakatResponse>> getAllZakat();

  Future<ProductDataResponse> getProductData(
      GetProductDataRequest getProductDataRequest);

  Future<List<ZakatProductsResponse>> getZakatProductsByZatatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest);

  Future<List<ZakatProductsByKilosResponse>> getAllZakatProductsByKilos();
}

class ZakatDataSource extends BaseDataSource {
  final DioManager _dio;

  ZakatDataSource(this._dio);

  @override
  Future<void> register(RegisterRequest registerRequest) async {
    try {
      await _dio.post('${ApiConstants.baseUrl}api/register',
          body: registerRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> login(LoginRequest loginRequest) async {
    try {
      await _dio.post('${ApiConstants.baseUrl}api/login',
          body: loginRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post('${ApiConstants.baseUrl}api/logout',
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteProductData(
      DeleteProductRequest deleteProductRequest) async {
    try {
      await _dio.delete(
          '${ApiConstants.baseUrl}api/products/${deleteProductRequest.id}',
          body: deleteProductRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteAllZakatData() async {
    try {
      await _dio.delete('${ApiConstants.baseUrl}api/deleteAllUserZakats',
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteZakatData(DeleteZakatRequest deleteZakatRequest) async {
    try {
      await _dio.delete(
          '${ApiConstants.baseUrl}api/zakat/${deleteZakatRequest.id}',
          body: deleteZakatRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ProductsResponse>> getAllProducts() async {
    List<ProductsResponse> res = <ProductsResponse>[];
    try {
      return await _dio.get('api/product', headers: {
        'Authorization': 'Bearer ${ApiConstants.token}'
      }).then((response) {
        res = (response.data['result'] as List).map((e) {
          return ProductsResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ZakatResponse>> getAllZakat() async {
    List<ZakatResponse> res = <ZakatResponse>[];
    try {
      return await _dio.get('api/zakats', headers: {
        'Authorization': 'Bearer ${ApiConstants.token}'
      }).then((response) {
        res = (response.data['result'] as List).map((e) {
          return ZakatResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<ProductDataResponse> getProductData(
      GetProductDataRequest getProductDataRequest) async {
    var res;
    try {
      return await _dio.get('api/products/${getProductDataRequest.id}',
          headers: {
            'Authorization': 'Bearer ${ApiConstants.token}'
          }).then((response) {
        res = (response.data['result'] as List).map((e) {
          return ProductDataResponse.fromJson(e);
        });
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ZakatProductsByKilosResponse>>
      getAllZakatProductsByKilos() async {
    List<ZakatProductsByKilosResponse> res = <ZakatProductsByKilosResponse>[];
    try {
      return await _dio.get('api/getUserProductTotals', headers: {
        'Authorization': 'Bearer ${ApiConstants.token}'
      }).then((response) {
        res = (response.data['result'] as List).map((e) {
          return ZakatProductsByKilosResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ZakatProductsResponse>> getZakatProductsByZatatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest) async {
    List<ZakatProductsResponse> res = <ZakatProductsResponse>[];
    try {
      return await _dio.get(
          'api/${getZakatProductsByZatatIdRequest.zakatId}/showZakatProducts',
          headers: {
            'Authorization': 'Bearer ${ApiConstants.token}'
          }).then((response) {
        res = (response.data['result'] as List).map((e) {
          return ZakatProductsResponse.fromJson(e);
        }).toList();
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> insertProductData(
      InsertProductRequest insertProductRequest) async {
    try {
      await _dio.post('${ApiConstants.baseUrl}api/products',
          body: insertProductRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> insertZakatData(InsertZakatRequest insertZakatRequest) async {
    try {
      await _dio.post('${ApiConstants.baseUrl}api/zakat',
          body: insertZakatRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateProductData(
      UpdateProductRequest updateProductRequest) async {
    try {
      await _dio.put(
          '${ApiConstants.baseUrl}api/products/${ApiConstants.productData}',
          body: updateProductRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.token}'});
    } catch (e) {
      throw e.toString();
    }
  }
}
