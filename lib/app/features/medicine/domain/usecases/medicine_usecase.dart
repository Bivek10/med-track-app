import 'package:fpdart/fpdart.dart';

import '../../../../core/config/api/index.dart';
import '../../../../core/utils/typedf/index.dart';
import '../entities/medicine_entity.dart';
import '../repository/medicine_repository.dart';

class MedicineUsecase {
  final MedicineRepository _medicineRepository;

  MedicineUsecase(this._medicineRepository);

  Future<Either<Failure, ApiResponse<List<MedicineEntity>>>> callGetMedicines({
    int limit = 10,
    int page = 1,
    String? orderBy,
  }) {
    return _medicineRepository.getMedicines(
      limit: limit,
      page: page,
      orderBy: orderBy,
    );
  }

  Future<Either<Failure, ApiResponse<MedicineEntity>>> callCreateMedicine(
    JsonMap data,
  ) {
    return _medicineRepository.createMedicine(data);
  }

  Future<Either<Failure, ApiResponse<MedicineEntity>>> callUpdateMedicine(
    int id,
    JsonMap data,
  ) {
    return _medicineRepository.updateMedicine(id, data);
  }

  Future<Either<Failure, ApiResponse<void>>> callDeleteMedicine(int id) {
    return _medicineRepository.deleteMedicine(id);
  }
}
