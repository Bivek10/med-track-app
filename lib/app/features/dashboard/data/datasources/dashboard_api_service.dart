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
    return _dioService.makeRequest<IntakeListResponseModel, dynamic>(
      type: RequestType.get,
      endpoint: ApiEndpoints.todayIntakes,
      fromJson: (json) {
        if (json is List) {
          return IntakeListResponseModel(
            intakes: json.map((e) => IntakeModel.fromJson(e as JsonMap)).toList(),
          );
        }
        final data = (json as JsonMap)['data'];
        return IntakeListResponseModel.fromJson(data is JsonMap ? data : json as JsonMap);
      },
    );
  }

  @override
  Future<Either<Failure, ApiResponse<AdherenceModel>>> getAdherence() async {
    return _dioService.makeRequest<AdherenceModel, JsonMap>(
      type: RequestType.get,
      endpoint: ApiEndpoints.adherence,
      queryParameters: {
        "period":'daily',
      },
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
      endpoint: ApiEndpoints.intakeStatus.replaceFirst('{id}', id.toString()) ,
      data: {
        'status': status,
      },
      fromJson: (_) {},
    );
  }
}
