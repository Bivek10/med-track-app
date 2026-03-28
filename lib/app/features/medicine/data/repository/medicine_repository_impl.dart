import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/index.dart';
import '../../../../core/utils/typedf/index.dart';
import '../../domain/entities/medicine_entity.dart';
import '../../domain/repository/medicine_repository.dart';
import '../datasources/medicine_api_service.dart';

class MedicineRepositoryImpl implements MedicineRepository {
  final MedicineApiService _medicineApiService;

  MedicineRepositoryImpl(this._medicineApiService);

  @override
  Future<Either<Failure, ApiResponse<List<MedicineEntity>>>> getMedicines({
    int limit = 10,
    int page = 1,
    String? orderBy,
  }) async {
    final result = await _medicineApiService.getMedicines(
      limit: limit,
      page: page,
      orderBy: orderBy,
    );
    return result.map((response) {
      final entities = response.data.medicines.map((e) => e.toEntity()).toList();
      return ApiResponse<List<MedicineEntity>>(
        data: entities,
        statusCode: response.statusCode,
      );
    });
  }

  @override
  Future<Either<Failure, ApiResponse<MedicineEntity>>> createMedicine(
    JsonMap data,
  ) async {
    final result = await _medicineApiService.createMedicine(data);
    return result.map((response) {
      return ApiResponse<MedicineEntity>(
        data: response.data.toEntity(),
        statusCode: response.statusCode,
      );
    });
  }

  @override
  Future<Either<Failure, ApiResponse<MedicineEntity>>> updateMedicine(
    int id,
    JsonMap data,
  ) async {
    final result = await _medicineApiService.updateMedicine(id, data);
    return result.map((response) {
      return ApiResponse<MedicineEntity>(
        data: response.data.toEntity(),
        statusCode: response.statusCode,
      );
    });
  }

  @override
  Future<Either<Failure, ApiResponse<void>>> deleteMedicine(int id) {
    return _medicineApiService.deleteMedicine(id);
  }
}
