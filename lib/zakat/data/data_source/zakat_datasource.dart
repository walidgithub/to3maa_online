import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/get_product_data_request.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/domain/responses/auth/get_user_data_response.dart';
import 'package:To3maa/zakat/domain/responses/auth/login_response.dart';
import 'package:To3maa/zakat/domain/responses/auth/register_response.dart';
import 'package:To3maa/zakat/domain/responses/product_data_response.dart';
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/dio_manager.dart';
import '../../domain/requests/auth/login_request.dart';
import '../../domain/requests/auth/register_request.dart';
import '../../domain/requests/auth/forgot_password_request.dart';
import '../../domain/requests/auth/reset_password_request.dart';
import '../../domain/responses/auth/forgot_password_response.dart';

abstract class BaseDataSource {
  Future<RegisterResponse> register(RegisterRequest registerRequest);
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<void> logout();

  Future<void> insertProductData(InsertProductRequest insertProductRequest);
  Future<void> insertZakatData(InsertZakatRequest insertZakatRequest);

  Future<void> updateProductData(UpdateProductRequest updateProductRequest);
  Future<ForgotPasswordResponse> checkEmail(ForgotPassRequest forgotPassRequest);
  Future<void> resetPass(ResetPassRequest resetPassRequest);

  Future<void> deleteProductData(DeleteProductRequest deleteProductRequest);
  Future<void> deleteZakatData(DeleteZakatRequest deleteZakatRequest);
  Future<void> deleteAllZakatData();

  Future<UserDataResponse> getUserData();
  Future<List<ProductsResponse>> getAllProducts();
  Future<ProductDataResponse> getProductData(
      GetProductDataRequest getProductDataRequest);
  Future<List<ZakatResponse>> getAllZakat();
  Future<List<ZakatProductsResponse>> getZakatProductsByZatatId(
      GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest);
  Future<List<ZakatProductsByKilosResponse>> getAllZakatProductsByKilos();
}

class ZakatDataSource extends BaseDataSource {
  final DioManager _dio;

  ZakatDataSource(this._dio);

  @override
  Future<RegisterResponse> register(RegisterRequest registerRequest) async {
    var res;
    try {
      return await _dio.post('${ApiConstants.baseUrl}api/register',
          body: registerRequest.toJson()).then((response) {
        res = (response.data['result'] as List).map((e) {
          return UserDataResponse.fromJson(e);
        });
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    var res;
    try {
      return await _dio.post('${ApiConstants.baseUrl}api/login',
          body: loginRequest.toJson()).then((response) {
        res = (response.data['result'] as List).map((e) {
          return UserDataResponse.fromJson(e);
        });
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dio.post('${ApiConstants.baseUrl}api/logout',
          headers: {'Authorization': 'Bearer ${ApiConstants.getToken}'});
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
          headers: {'Authorization': 'Bearer ${ApiConstants.getToken}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteAllZakatData() async {
    try {
      await _dio.delete('${ApiConstants.baseUrl}api/deleteAllUserZakats',
          headers: {'Authorization': 'Bearer ${ApiConstants.getToken}'});
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
          headers: {'Authorization': 'Bearer ${ApiConstants.getToken}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<UserDataResponse> getUserData() async {
    var res;
    try {
      return await _dio.get('${ApiConstants.baseUrl}api/users',
          headers: {
            'Authorization': 'Bearer ${ApiConstants.getToken}'
          }).then((response) {
        res = (response.data['result'] as List).map((e) {
          return UserDataResponse.fromJson(e);
        });
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<ProductsResponse>> getAllProducts() async {
    List<ProductsResponse> res = <ProductsResponse>[];
    try {
      return await _dio.get('${ApiConstants.baseUrl}api/product', headers: {
        'Authorization': 'Bearer ${ApiConstants.getToken}'
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
      return await _dio.get('${ApiConstants.baseUrl}api/zakats', headers: {
        'Authorization': 'Bearer ${ApiConstants.getToken}'
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
      return await _dio.get('${ApiConstants.baseUrl}api/products/${getProductDataRequest.id}',
          headers: {
            'Authorization': 'Bearer ${ApiConstants.getToken}'
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
      return await _dio.get('${ApiConstants.baseUrl}api/getUserProductTotals', headers: {
        'Authorization': 'Bearer ${ApiConstants.getToken}'
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
          '${ApiConstants.baseUrl}api/${getZakatProductsByZatatIdRequest.zakatId}/showZakatProducts',
          headers: {
            'Authorization': 'Bearer ${ApiConstants.getToken}'
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
          headers: {'Authorization': 'Bearer ${ApiConstants.getToken}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> insertZakatData(InsertZakatRequest insertZakatRequest) async {
    try {
      await _dio.post('${ApiConstants.baseUrl}api/zakat',
          body: insertZakatRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.getToken}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateProductData(
      UpdateProductRequest updateProductRequest) async {
    try {
      await _dio.put(
          '${ApiConstants.baseUrl}api/products/${ApiConstants.getProductId}',
          body: updateProductRequest.toJson(),
          headers: {'Authorization': 'Bearer ${ApiConstants.getToken}'});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<ForgotPasswordResponse> checkEmail(ForgotPassRequest forgotPassRequest) async {
    var res;
    try {
      return await _dio.put('${ApiConstants.baseUrl}api/forgotPass',
          body: forgotPassRequest.toJson()).then((response) {
        res = (response.data['result'] as List).map((e) {
          return ForgotPasswordResponse.fromJson(e);
        });
        return res;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> resetPass(ResetPassRequest resetPassRequest) async {
    try {
      await _dio.put(
          '${ApiConstants.baseUrl}api/resetPass',
          body: resetPassRequest.toJson());
    } catch (e) {
      throw e.toString();
    }
  }
}
