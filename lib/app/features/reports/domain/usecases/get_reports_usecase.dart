import 'package:fpdart/fpdart.dart';
import '../../../../core/config/api/api_error.dart';
import '../entities/adherence_report_entity.dart';
import '../entities/missed_dose_entity.dart';
import '../repositories/report_repository.dart';

class GetReportsUseCase {
  final ReportRepository _repository;

  GetReportsUseCase(this._repository);

  Future<Either<Failure, AdherenceReportEntity>> getAdherenceReport(String period) {
    return _repository.getAdherenceReport(period);
  }

  Future<Either<Failure, List<MissedDoseEntity>>> getMissedDoses() {
    return _repository.getMissedDoses();
  }
}
