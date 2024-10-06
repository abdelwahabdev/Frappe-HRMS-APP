import 'dart:developer';

import 'package:flutter/foundation.dart';

///! Helper function to log errors
///* required message
///
void debugLog(String message) {
  if (kDebugMode) {
    log(message);
  }
}
