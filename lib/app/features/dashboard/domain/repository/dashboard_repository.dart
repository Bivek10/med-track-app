import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/api_error.dart';
import '../entities/adherence_entity.dart';
import '../entities/intake_entity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<IntakeEntity>>> getTodaysIntakes();
  Future<Either<Failure, AdherenceEntity>> getAdherence();
  Future<Either<Failure, void>> updateIntakeStatus(int id, String status);
}
