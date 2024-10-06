class BranchListModel {
  final String branchName;
  final double branchLatitude;
  final double branchLongitude;
  final double acceptanceRadius;

  BranchListModel({
    required this.branchName,
    required this.branchLatitude,
    required this.branchLongitude,
    required this.acceptanceRadius,
  });

  // Factory constructor to create an instance from JSON
  factory BranchListModel.fromJson(Map<String, dynamic> json) {
    return BranchListModel(
      branchName: json['branch_name'],
      branchLatitude: json['branch_latitude'],
      branchLongitude: json['branch_longitude'],
      acceptanceRadius: json['acceptance_radius'],
    );
  }

  // Convert BranchListModel instance to JSON
}
