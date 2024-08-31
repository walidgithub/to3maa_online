import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../error/error_handler.dart';
import 'api_constants.dart';


/// Class that makes API call easier
class DioManager {
  Dio? _dioInstance;

  Dio? get dio {
    _dioInstance ??= initDio();
    return _dioInstance;
  }

  Dio initDio() {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        headers: <String, String> {},
        sendTimeout: 30000,
        connectTimeout: 20000,
        receiveTimeout: 60000,
      ),
    );
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
    }
    return dio;
  }

  void update() => _dioInstance = initDio();

  /// DIO GET
  /// take [path], concrete route
  Future<Response> get(
      String path, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? parameters,
      }) async {
    return await dio!.get(
      path,
      queryParameters: parameters,
      options: Options(headers: headers),
    ).then((response) {
      return response;
    }).catchError((dynamic error) async {
      throw ErrorHandler.handle(error).failure;
    });
  }

  /// DIO POST
  /// take [path], concrete route
  Future<Response> post(
      String path, {
        Map<String, dynamic>? headers,
        dynamic body,
      }) async {
    return await dio!.post(
      path,
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
          headers: headers),
    ).then((response) {
      return response;
    }).catchError((dynamic error) {
      throw ErrorHandler.handle(error).failure;
    });
  }

  /// DIO PUT
  /// take [path], concrete route
  Future<Response> put(
      String path, {
        Map<String, dynamic>? headers,
        dynamic body,
      }) async {
    return await dio!.put(
      path,
      data: body,
      options: Options(headers: headers),
    ).then((response) {
      return response;
    }).catchError((dynamic error) {
      throw ErrorHandler.handle(error).failure;
    });
  }

  /// DIO DELETE
  /// take [path], concrete route
  Future<Response> delete(
      String path, {
        Map<String, dynamic>? headers,
        dynamic body,
      }) async {
    return await dio!.delete(
      path,
      data: body,
      options: Options(headers: headers),
    ).then((response) {
      return response;
    }).catchError((dynamic error) {
      throw ErrorHandler.handle(error).failure;
    });
  }
}
