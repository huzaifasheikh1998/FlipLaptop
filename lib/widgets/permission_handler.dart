import 'package:app_fliplaptop/widgets/permission_alert.dart';
import 'package:geolocator/geolocator.dart';

class PermissionHandler {

  static Future<bool> getLocationPermission(context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    }
    else {
      bool? allow;
      allow = await locationPermissionAlert(context);
      return allow!;

    }
    // else {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.always ||
    //       permission == LocationPermission.whileInUse) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }
  }
}