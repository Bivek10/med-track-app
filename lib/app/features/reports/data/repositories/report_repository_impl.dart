import 'package:fpdart/fpdart.dart';
import '../../../../core/config/api/api_error.dart';
import '../../domain/entities/adherence_report_entity.dart';
import '../../domain/entities/missed_dose_entity.dart';
import '../../domain/repositories/report_repository.dart';
import '../datasources/report_api_service.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportApiService _apiService;

  ReportRepositoryImpl(this._apiService);

  @override
  Future<Either<Failure, AdherenceReportEntity>> getAdherenceReport(String period) async {
    final result = await _apiService.getAdherenceReport(period);
    return result.map((response) => response.data.toEntity());
  }

  @override
  Future<Either<Failure, List<MissedDoseEntity>>> getMissedDoses() async {
    final result = await _apiService.getMissedDoses();
    return result.map((response) => response.data.missedDoses.map((m) => m.toEntity()).toList());
  }
}
