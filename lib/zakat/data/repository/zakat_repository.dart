import 'package:To3maa/zakat/domain/requests/get_product_data_request.dart';
import 'package:To3maa/zakat/domain/responses/auth/get_user_data_response.dart';
import 'package:To3maa/zakat/domain/responses/product_data_response.dart';
import 'package:dartz/dartz.dart';
import 'package:To3maa/core/error/error_handler.dart';
import 'package:To3maa/core/error/failure.dart';
import 'package:To3maa/zakat/data/data_source/zakat_datasource.dart';
import 'package:To3maa/zakat/domain/repository/base_repository.dart';
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
import '../../domain/requests/auth/login_request.dart';
import '../../domain/requests/auth/register_request.dart';

class ZakatRepository extends BaseRepository {
  final BaseDataSource _baseDataSource;

  ZakatRepository(
    this._baseDataSource,
  );
  @override
  Future<Either<Failure, void>> register(
      RegisterRequest registerRequest) async {
    try {
      final result =
      await _baseDataSource.register(registerRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> login(
      LoginRequest loginRequest) async {
    try {
      final result =
      await _baseDataSource.login(loginRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result =
      await _baseDataSource.logout();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteProductData(
      DeleteProductRequest deleteProductRequest) async {
    try {
      final result =
          await _baseDataSource.deleteProductData(deleteProductRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteZakatData(
      DeleteZakatRequest deleteZakatRequest) async {
    try {
      final result = await _baseDataSource.deleteZakatData(deleteZakatRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllZakatData() async {
    try {
      final result = await _baseDataSource.deleteAllZakatData();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ZakatProductsResponse>>>
      getZakatProductsByZakatId(
          GetZakatProductsByZatatIdRequest
              getZakatProductsByZatatIdRequest) async {
    try {
      final result = await _baseDataSource
          .getZakatProductsByZatatId(getZakatProductsByZatatIdRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ProductsResponse>>> getAllProducts() async {
    try {
      final result = await _baseDataSource.getAllProducts();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ZakatResponse>>> getAllZakat() async {
    try {
      final result = await _baseDataSource.getAllZakat();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<ZakatProductsByKilosResponse>>>
      getAllZakatProductsByKilos() async {
    try {
      final result = await _baseDataSource.getAllZakatProductsByKilos();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }


  @override
  Future<Either<Failure, ProductDataResponse>> getProductData(GetProductDataRequest getProductDataRequest) async {
    try {
      final result = await _baseDataSource.getProductData(getProductDataRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> insertProductData(
      InsertProductRequest insertProductRequest) async {
    try {
      final result =
          await _baseDataSource.insertProductData(insertProductRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> insertZakatData(
      InsertZakatRequest insertZakatRequest) async {
    try {
      final result = await _baseDataSource.insertZakatData(insertZakatRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updateProductData(
      UpdateProductRequest updateProductRequest) async {
    try {
      final result =
          await _baseDataSource.updateProductData(updateProductRequest);
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, UserDataResponse>> getUserData() async {
    try {
      final result = await _baseDataSource.getUserData();
      return Right(result);
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
