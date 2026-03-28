import '../../../../core/utils/typedf/index.dart';
import '../../domain/entities/user_entity.dart';

class UserM {
  final int userId;
  final String email;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? authProvider;
  final String? profilePicture;
  final String? role;
  final String? accessToken;
  final String? refreshToken;

  UserM({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.authProvider,
    this.profilePicture,
    this.role,
    this.accessToken,
    this.refreshToken,
  });

  factory UserM.fromJson(JsonMap json) {
    return UserM(
      userId: (json['user_id'] ?? json['id']) as int,
      email: json['email'] as String,
      firstName: (json['first_name'] ?? json['firstName']) as String,
      lastName: (json['last_name'] ?? json['lastName']) as String,
      middleName: (json['middle_name'] ?? json['middleName']) as String?,
      authProvider: (json['auth_provider'] ?? json['authProvider']) as String?,
      profilePicture: (json['profile_picture'] ?? json['image']) as String?,
      role: json['role'] as String?,
      accessToken: (json['access_token'] ?? json['accessToken']) as String?,
      refreshToken: (json['refresh_token'] ?? json['refreshToken']) as String?,
    );
  }

  JsonMap toJson() {
    return {
      'user_id': userId,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'middle_name': middleName,
      'auth_provider': authProvider,
      'role': role,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      fullname: '$firstName ${middleName ?? ""} $lastName'.trim(),
      email: email,
      role: role ?? 'USER',
      profile: profilePicture ?? '',
    );
  }
}
