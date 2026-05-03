import 'package:fpdart/fpdart.dart';
import '../../../../core/config/api/api_error.dart';
import '../../domain/entities/adherence_entity.dart';
import '../../domain/entities/intake_entity.dart';
import '../../domain/repository/dashboard_repository.dart';
import '../datasources/dashboard_api_service.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApiService remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<IntakeEntity>>> getTodaysIntakes() async {
    final result = await remoteDataSource.getTodaysIntakes();
    return result.map((response) {
      return response.data.intakes.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, AdherenceEntity>> getAdherence() async {
    final result = await remoteDataSource.getAdherence();
    return result.map((response) {
      return response.data.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> updateIntakeStatus(int id, String status) async {
    final result = await remoteDataSource.updateIntakeStatus(id, status);
    return result.map((_) => null);
  }
}
