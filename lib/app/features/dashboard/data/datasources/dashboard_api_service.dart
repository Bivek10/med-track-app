import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/index.dart';
import '../../../../core/utils/enum/index.dart';
import '../../../../core/utils/typedf/index.dart' show JsonMap;
import '../models/adherence_model.dart';
import '../models/intake_model.dart';

abstract class DashboardApiService {
  Future<Either<Failure, ApiResponse<IntakeListResponseModel>>> getTodaysIntakes();
  Future<Either<Failure, ApiResponse<AdherenceModel>>> getAdherence();
  Future<Either<Failure, ApiResponse<void>>> updateIntakeStatus(int id, String status);
}

class DashboardApiServiceImpl implements DashboardApiService {
  final DioService _dioService;

  DashboardApiServiceImpl(this._dioService);

  @override
  Future<Either<Failure, ApiResponse<IntakeListResponseModel>>> getTodaysIntakes() async {
    return _dioService.makeRequest<IntakeListResponseModel, JsonMap>(
      type: RequestType.get,
      endpoint: '/api/v1/intakes/today',
      fromJson: (json) {
        final data = json['data'];
        return IntakeListResponseModel.fromJson(data is JsonMap ? data : json);
      },
    );
  }

  @override
  Future<Either<Failure, ApiResponse<AdherenceModel>>> getAdherence() async {
    return _dioService.makeRequest<AdherenceModel, JsonMap>(
      type: RequestType.get,
      endpoint: '/api/v1/reports/adherence?period=daily',
      fromJson: (json) {
        final data = json['data'];
        return AdherenceModel.fromJson(data is JsonMap ? data : json);
      },
    );
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> updateIntakeStatus(int id, String status) async {
    return _dioService.makeRequest<void, JsonMap>(
      type: RequestType.put,
      endpoint: '/api/v1/intakes/$id/status',
      data: {
        'status': status,
      },
      fromJson: (_) {},
    );
  }
}
