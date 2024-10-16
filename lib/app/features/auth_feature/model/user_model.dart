class UserModel {
  final String message;
  final UserDataModel data;

  UserModel({required this.message, required this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      data: UserDataModel.fromJson(json['data']),
    );
  }
}

class UserDataModel {
  final String token;
  final String username;
  final String email;
  final String fullName;
  final String? employee;
  final String? employeeName;
  final double latitude;
  final double longitude;
  final double acceptanceRadius;
  final String? branchName;
  final int enableRemote;

  UserDataModel({
    required this.token,
    required this.username,
    required this.email,
    required this.fullName,
    required this.latitude,
    required this.longitude,
    required this.acceptanceRadius,
    required this.enableRemote,
    this.branchName,
    this.employee,
    this.employeeName,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      token: json['token'],
      username: json['username'],
      email: json['email'] ?? ' ',
      enableRemote: json['enable_remote'] ?? 0,
      fullName: json['full_name'] ?? ' ',
      employee: json['employee'],
      employeeName: json['employee_name'] ?? ' ',
      latitude: json['company_latitude'] ?? 0.0,
      longitude: json['company_longitude'] ?? 0.0,
      acceptanceRadius: json['acceptance_radius'] ?? 0.0,
      branchName: json['branch_name'] ?? ' ',
    );
  }
}
