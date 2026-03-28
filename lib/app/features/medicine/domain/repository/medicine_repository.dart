import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/index.dart';
import '../../../../core/utils/typedf/index.dart';
import '../entities/medicine_entity.dart';

abstract class MedicineRepository {
  Future<Either<Failure, ApiResponse<List<MedicineEntity>>>> getMedicines({
    int limit = 10,
    int page = 1,
    String? orderBy,
  });
  Future<Either<Failure, ApiResponse<MedicineEntity>>> createMedicine(
    JsonMap data,
  );
  Future<Either<Failure, ApiResponse<MedicineEntity>>> updateMedicine(
    int id,
    JsonMap data,
  );
  Future<Either<Failure, ApiResponse<void>>> deleteMedicine(int id);
}
