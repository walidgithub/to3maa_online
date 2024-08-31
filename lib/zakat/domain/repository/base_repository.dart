import 'package:To3maa/zakat/domain/requests/get_product_data_request.dart';
import 'package:To3maa/zakat/domain/responses/auth/get_user_data_response.dart';
import 'package:To3maa/zakat/domain/responses/product_data_response.dart';
import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/domain/requests/delete_product_request.dart';
import 'package:To3maa/zakat/domain/requests/delete_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/get_zakat_products_by_zakat_id_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_product_request.dart';
import 'package:To3maa/zakat/domain/requests/insert_zakat_request.dart';
import 'package:To3maa/zakat/domain/requests/update_product_request.dart';
import 'package:To3maa/zakat/domain/responses/products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_by_kilos_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_products_response.dart';
import 'package:To3maa/zakat/domain/responses/zakat_response.dart';

import '../requests/auth/login_request.dart';
import '../requests/auth/register_request.dart';

abstract class BaseRepository {
  Future<Either<Failure, void>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, void>> login(
      LoginRequest loginRequest);
  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> insertZakatData(
      InsertZakatRequest insertZakatRequest);
  Future<Either<Failure, void>> insertProductData(
      InsertProductRequest insertProductRequest);

  Future<Either<Failure, void>> updateProductData(
      UpdateProductRequest updateProductRequest);

  Future<Either<Failure, void>> deleteZakatData(
      DeleteZakatRequest deleteZakatRequest);
  Future<Either<Failure, void>> deleteAllZakatData();
  Future<Either<Failure, void>> deleteProductData(
      DeleteProductRequest deleteProductRequest);

  Future<Either<Failure, UserDataResponse>> getUserData();
  Future<Either<Failure, List<ProductsResponse>>> getAllProducts();
  Future<Either<Failure, List<ZakatResponse>>> getAllZakat();
  Future<Either<Failure, ProductDataResponse>> getProductData(GetProductDataRequest getProductDataRequest);
  Future<Either<Failure, List<ZakatProductsResponse>>>
      getZakatProductsByZakatId(
          GetZakatProductsByZatatIdRequest getZakatProductsByZatatIdRequest);
  Future<Either<Failure, List<ZakatProductsByKilosResponse>>>
      getAllZakatProductsByKilos();
}
