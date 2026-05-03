import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/index.dart';
import '../../../../core/utils/enum/index.dart';
import '../../../../core/utils/typedf/index.dart' show JsonMap;
import '../models/adherence_report_model.dart';
import '../models/missed_dose_model.dart';

abstract class ReportApiService {
  Future<Either<Failure, ApiResponse<AdherenceReportModel>>> getAdherenceReport(String period);
  Future<Either<Failure, ApiResponse<MissedDoseListResponseModel>>> getMissedDoses();
}

class ReportApiServiceImpl implements ReportApiService {
  final DioService _dioService;

  ReportApiServiceImpl(this._dioService);

  @override
  Future<Either<Failure, ApiResponse<AdherenceReportModel>>> getAdherenceReport(String period) async {
    return _dioService.makeRequest<AdherenceReportModel, JsonMap>(
      type: RequestType.get,
      endpoint: ApiEndpoints.adherence,
      queryParameters: {
        "period": period,
      },
      fromJson: (json) {
        final data = json['data'];
        return AdherenceReportModel.fromJson(data is JsonMap ? data : json);
      },
    );
  }

  @override
  Future<Either<Failure, ApiResponse<MissedDoseListResponseModel>>> getMissedDoses() async {
    return _dioService.makeRequest<MissedDoseListResponseModel, dynamic>(
      type: RequestType.get,
      endpoint: ApiEndpoints.missedDoses,
      fromJson: (json) {
        if (json is List) {
          return MissedDoseListResponseModel.fromJson(json);
        }
        final data = (json as JsonMap)['data'];
        if (data is List) {
          return MissedDoseListResponseModel.fromJson(data);
        }
        return MissedDoseListResponseModel(missedDoses: []);
      },
    );
  }
}
