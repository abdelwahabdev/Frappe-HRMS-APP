import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../common/custom_snakbar.dart';
import '../../../utils/helper/depug_log.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticate() async {
    try {
      final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      if (canAuthenticateWithBiometrics) {
        final availableBiometrics = await _auth.getAvailableBiometrics();
        if (availableBiometrics.isNotEmpty) {
          final authenticated = await _auth.authenticate(
            localizedReason: 'Authenticate to perform the action',
          );

          if (authenticated) {
            debugLog('Authenticated successfully');
            return true;
          } else {
            // Biometric authentication f  ailed
            showCustomSnackBar(
              'Authentication failed. Please try again.',
              isError: true,
            );
            return false;
          }
        } else {
          // No biometrics available
          showCustomSnackBar(
            'Biometric authentication is not available on this device.'.tr,
            isError: true,
          );
          return false;
        }
      }
      return false;
    } catch (e) {
      debugLog('Error authenticating with biometrics: $e');
      // Handle error
      return false;
    }
  }
}
