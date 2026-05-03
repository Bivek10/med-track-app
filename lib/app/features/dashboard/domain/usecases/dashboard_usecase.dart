import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/api_error.dart';
import '../entities/adherence_entity.dart';
import '../entities/intake_entity.dart';
import '../repository/dashboard_repository.dart';

class DashboardUsecase {
  final DashboardRepository repository;

  DashboardUsecase(this.repository);

  Future<Either<Failure, List<IntakeEntity>>> getTodaysIntakes() {
    return repository.getTodaysIntakes();
  }

  Future<Either<Failure, AdherenceEntity>> getAdherence() {
    return repository.getAdherence();
  }

  Future<Either<Failure, void>> updateIntakeStatus(int id, String status) {
    return repository.updateIntakeStatus(id, status);
  }
}
