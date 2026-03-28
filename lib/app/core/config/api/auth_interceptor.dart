import 'dart:developer';
import 'dart:io' show HttpHeaders;

import 'package:dio/dio.dart'
    show
        DioException,
        ErrorInterceptorHandler,
        Interceptor,
        RequestInterceptorHandler,
        RequestOptions,
        Response,
        ResponseInterceptorHandler;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show FlutterSecureStorage;
import 'package:fpdart/fpdart.dart';

import '../../../features/auth/domain/entities/refresh_entity.dart';
import '../../../features/auth/domain/usecases/auth_usecase.dart';
import '../../../injector.dart';
import '../../utils/enum/index.dart' show SecureStorageKey;
import 'api_endpoints.dart';
import 'api_response.dart';
import 'dio_client.dart';

class DioAuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await inject<FlutterSecureStorage>().read(
        key: SecureStorageKey.bearerToken.name,
      );
      log("token::: ${token}");
      if (token != null && token.isNotEmpty) {
        options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      }
    } catch (e) {
      debugPrint("Error reading token from storage: $e");
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.path == ApiEndpoints.login ||
        response.requestOptions.path == ApiEndpoints.register ||
        response.requestOptions.path == ApiEndpoints.refreshToken) {
      final responseData = response.data?['data'];
      if (responseData != null) {
        await Future.wait([
          inject<FlutterSecureStorage>().write(
            key: SecureStorageKey.bearerToken.name,
            value: responseData['access_token'] as String?,
          ),
          inject<FlutterSecureStorage>().write(
            key: SecureStorageKey.refreshToken.name,
            value: responseData['refresh_token'] as String?,
          ),
        ]);
      }
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final accessToken = await inject<FlutterSecureStorage>().read(
      key: SecureStorageKey.bearerToken.name,
    );

    if (err.response?.statusCode == 401 && accessToken != null) {
      final refreshToken = await inject<FlutterSecureStorage>().read(
        key: SecureStorageKey.refreshToken.name,
      );

      final result = await inject<AuthUsecase>().callRefresh({
        "refresh_token": refreshToken,
      });

      if (result.isRight()) {
        final refreshData =
            result.getRight().getOrElse(() => throw Exception()).data;

        final newAccessToken = refreshData.accessToken;
        err.requestOptions.headers[HttpHeaders.authorizationHeader] =
            "Bearer $newAccessToken";

        try {
          final response =
              await inject<DioClient>().dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    handler.next(err);
  }
}
