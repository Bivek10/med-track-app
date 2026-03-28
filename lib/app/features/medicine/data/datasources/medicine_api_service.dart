import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/index.dart';
import '../../../../core/utils/enum/index.dart';
import '../../../../core/utils/typedf/index.dart';
import '../models/medicine_model.dart';

abstract class MedicineApiService {
  Future<Either<Failure, ApiResponse<MedicineListResponseModel>>> getMedicines({
    int limit = 10,
    int page = 0,
    String? orderBy,
  });
  Future<Either<Failure, ApiResponse<MedicineModel>>> createMedicine(
    JsonMap data,
  );
  Future<Either<Failure, ApiResponse<MedicineModel>>> updateMedicine(
    int id,
    JsonMap data,
  );
  Future<Either<Failure, ApiResponse<void>>> deleteMedicine(int id);
}

class MedicineApiServiceImpl implements MedicineApiService {
  final DioService _dioService;

  MedicineApiServiceImpl(this._dioService);

  @override
  Future<Either<Failure, ApiResponse<MedicineListResponseModel>>> getMedicines({
    int limit = 10,
    int page = 1,
    String? orderBy,
  }) {
    return _dioService.makeRequest<MedicineListResponseModel, JsonMap>(
      type: RequestType.get,
      endpoint: ApiEndpoints.medicines,
      queryParameters: {
        'limit': limit,
        'page': page,
        if (orderBy != null) 'orderBy': orderBy,
      },
      fromJson: (json) => MedicineListResponseModel.fromJson(json),
    );
  }

  @override
  Future<Either<Failure, ApiResponse<MedicineModel>>> createMedicine(
    JsonMap data,
  ) {
    return _dioService.makeRequest<MedicineModel, JsonMap>(
      type: RequestType.post,
      endpoint: ApiEndpoints.medicines,
      data: data,
      fromJson: (json) {
        final resData = json['data'];
        return MedicineModel.fromJson(resData is JsonMap ? resData : json);
      },
    );
  }

  @override
  Future<Either<Failure, ApiResponse<MedicineModel>>> updateMedicine(
    int id,
    JsonMap data,
  ) {
    return _dioService.makeRequest<MedicineModel, JsonMap>(
      type: RequestType.put,
      endpoint: '${ApiEndpoints.medicines}/$id',
      data: data,
      fromJson: (json) {
        final resData = json['data'];
        return MedicineModel.fromJson(resData is JsonMap ? resData : json);
      },
    );
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> deleteMedicine(int id) {
    return _dioService.makeRequest<void, dynamic>(
      type: RequestType.delete,
      endpoint: '${ApiEndpoints.medicines}/$id',
      fromJson: (_) {},
    );
  }
}
