import 'package:bio_attend/app/utils/helper/data_converter.dart';

class EmployeeCheckin {
  String deviceId = 'Mobile App';
  String logType;
  String timestamp =
      DateConverter.dateTimeWithoutMiliseconds('${DateTime.now()}').toString();
  double longitude;
  double latitude;

  EmployeeCheckin({
    required this.logType,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "device_id": deviceId,
      "log_type": logType,
      "timestamp": timestamp,
      "longitude": longitude,
      "latitude": latitude,
    };
  }
}
