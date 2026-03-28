class UserEntity {
  final String fullname;
  final String email;
  final String role;
  final String profile;
  final String? gender;
  final int? age;
  final double? weight;
  final String? emergencyContactName;
  final String? emergencyContactNumber;

  UserEntity({
    required this.fullname,
    required this.email,
    required this.role,
    required this.profile,
    this.gender,
    this.age,
    this.weight,
    this.emergencyContactName,
    this.emergencyContactNumber,
  });
}
