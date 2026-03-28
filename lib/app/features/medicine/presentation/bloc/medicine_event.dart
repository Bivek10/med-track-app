part of 'medicine_bloc.dart';

sealed class MedicineEvent extends Equatable {
  const MedicineEvent();

  @override
  List<Object?> get props => [];
}

class FetchMedicines extends MedicineEvent {
  final bool refresh;
  final String? orderBy;

  const FetchMedicines({this.refresh = false, this.orderBy});

  @override
  List<Object?> get props => [refresh, orderBy];
}

class AddMedicine extends MedicineEvent {
  final JsonMap data;

  const AddMedicine(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateMedicine extends MedicineEvent {
  final int id;
  final JsonMap data;

  const UpdateMedicine(this.id, this.data);

  @override
  List<Object?> get props => [id, data];
}

class DeleteMedicine extends MedicineEvent {
  final int id;

  const DeleteMedicine(this.id);

  @override
  List<Object?> get props => [id];
}
