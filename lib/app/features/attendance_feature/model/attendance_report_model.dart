class AttendanceReportModel {
  final String employeeName;
  final String attendanceDate;
  final String status;
  final double workingHours;
  final String department;

  AttendanceReportModel({
    required this.employeeName,
    required this.attendanceDate,
    required this.status,
    required this.workingHours,
    required this.department,
  });

  factory AttendanceReportModel.fromJson(Map<String, dynamic> json) {
    return AttendanceReportModel(
      employeeName: json['employee_name'],
      attendanceDate: json['attendance_date'],
      status: json['status'],
      workingHours: json['working_hours'],
      department: json['department'],
    );
  }
}
