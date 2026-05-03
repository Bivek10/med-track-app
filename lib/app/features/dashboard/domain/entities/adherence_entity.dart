import 'package:equatable/equatable.dart';

class AdherenceEntity extends Equatable {
  final int takenCount;
  final int totalCount;
  final String message;

  const AdherenceEntity({
    required this.takenCount,
    required this.totalCount,
    required this.message,
  });

  @override
  List<Object?> get props => [
        takenCount,
        totalCount,
        message,
      ];
}
