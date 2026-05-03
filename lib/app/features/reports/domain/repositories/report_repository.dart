import 'package:fpdart/fpdart.dart';
import '../../../../core/config/api/api_error.dart';
import '../entities/adherence_report_entity.dart';
import '../entities/missed_dose_entity.dart';

abstract class ReportRepository {
  Future<Either<Failure, AdherenceReportEntity>> getAdherenceReport(String period);
  Future<Either<Failure, List<MissedDoseEntity>>> getMissedDoses();
}
