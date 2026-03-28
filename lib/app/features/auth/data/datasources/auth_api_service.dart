import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/index.dart';
import '../../../../core/utils/enum/index.dart';
import '../../../../core/utils/typedf/index.dart' show JsonMap;
import '../../domain/entities/refresh_entity.dart';
import '../models/user_model.dart';

abstract class AuthApiService {
  Future<Either<Failure, ApiResponse<UserM>>> signIn(JsonMap userMap);
  Future<Either<Failure, ApiResponse<UserM>>> signUp(JsonMap userMap);
  Future<Either<Failure, ApiResponse<UserM>>> getProfile();
  Future<Either<Failure, ApiResponse<UserM>>> updateProfile(JsonMap body);
  Future<Either<Failure, ApiResponse<RefreshEntity>>> refreshToken(
    JsonMap body,
  );
}

class AuthApiServiceImpl implements AuthApiService {
  final DioService _dioService;

  AuthApiServiceImpl(DioService dioService) : _dioService = dioService;

  @override
  Future<Either<Failure, ApiResponse<UserM>>> signIn(JsonMap userMap) async {
    return _dioService.makeRequest<UserM, JsonMap>(
      type: RequestType.post,
      endpoint: ApiEndpoints.login,
      fromJson: (json) {
        final data = json['data'];
        return UserM.fromJson(data is JsonMap ? data : json);
      },
      data: userMap,
    );
  }

  @override
  Future<Either<Failure, ApiResponse<UserM>>> signUp(JsonMap userMap) async {
    return _dioService.makeRequest<UserM, JsonMap>(
      type: RequestType.post,
      endpoint: ApiEndpoints.register,
      fromJson: (json) {
        final data = json['data'];
        return UserM.fromJson(data is JsonMap ? data : json);
      },
      data: userMap,
    );
  }

  @override
  Future<Either<Failure, ApiResponse<UserM>>> getProfile() async {
    return _dioService.makeRequest<UserM, JsonMap>(
      type: RequestType.get,
      endpoint: ApiEndpoints.profile,
      fromJson: (json) {
        final data = json['data'];
        return UserM.fromJson(data is JsonMap ? data : json);
      },
    );
  }

  @override
  Future<Either<Failure, ApiResponse<UserM>>> updateProfile(JsonMap body) async {
    return _dioService.makeRequest<UserM, JsonMap>(
      type: RequestType.put,
      endpoint: ApiEndpoints.updateProfile,
      fromJson: (json) {
        final data = json['data'];
        return UserM.fromJson(data is JsonMap ? data : json);
      },
      data: body,
    );
  }

  @override
  Future<Either<Failure, ApiResponse<RefreshEntity>>> refreshToken(
    JsonMap body,
  ) async {
    return _dioService.makeRequest<RefreshEntity, JsonMap>(
      type: RequestType.post,
      endpoint: ApiEndpoints.refreshToken,
      fromJson: RefreshEntity.fromJson,
      data: body,
    );
  }
}
