import 'dart:async';
import 'dart:developer';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreenController extends GetxController {
  LatLng? destinationPosition;
  LatLng? currentPosition;
  String? destinationPositionAddress;
  String currentPositionAddress = '';
  bool cameraInitialized = false;
  CameraPosition? initialMapCameraPosition;
  Timer? _debounce;
  String? editLeadAddress;
  Completer<GoogleMapController> mapController = Completer();
  TextEditingController searchController = TextEditingController();
  TextEditingController locationController = TextEditingController(text: "Downtown");


  double? latitude;
  double? longitude;


  void onCameraLocationChanged(LatLng value) {
    _debounce?.cancel();
    LatLng positionValue = value;
    _debounce = Timer(Duration(milliseconds: 500), () async {
      print("<<<<<<<updatedText$positionValue>>>>>>>");
      setUserCurrentLocation(positionValue);

      // Assuming setUserCurrentLocation updates destinationPositionAddress
      // If it doesn't, you'll need to set it here manually
      //destinationPositionAddress = "New Address based on $positionValue"; // Example

      destinationPositionAddress = await Utils.getAddressFromLatLng(
          value.latitude, value.longitude);
      locationController.text = destinationPositionAddress??"";

      latitude = value.latitude;
      longitude = value.longitude;
      print("CURRENT LATITUDE 3rd: ${value.latitude}");
      print("CURRENT LONGITUDE 3rd: ${value.longitude}");
      latitude = value.latitude;
      longitude = value.longitude;

      // Trigger UI update
      update();
    });
  }

  setUserCurrentLocation(LatLng value) {
    currentPosition = value;
    print("CURRENT LATITUDE 1st: ${value.latitude}");
    print("CURRENT LONGITUDE 1st: ${value.longitude}");
    latitude = value.latitude;
    longitude = value.longitude;
    setMapCameraPosition(value);
    // emitUserLocation();
    setCurrentPositionAddress(value);
  }

  searchAnimation(LatLng value) async {
    final GoogleMapController _controller = await mapController.future;
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: value,
      zoom: 14,
    )));
    update();
  }

  setCurrentPositionAddressInitial() {
    currentPositionAddress = "";
    update();
  }

  Future<void> getCurrentPosition(BuildContext context) async {
    print(
        "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<current position>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    final hasPermission =
    await PermissionHandler.getLocationPermission(context);
    if (!hasPermission) return;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showFloatingErrorSnack(
          'Location services are disabled. Please enable the services',
          );
    }
    try {
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        LatLng target = LatLng(position.latitude, position.longitude);
        setUserDestinationLocation(target);
      });
    } on LocationServiceDisabledException catch (e) {
      log(e.toString(), error: "User destination - getCurrentLocation");
      LatLng target = LatLng(40.730610, -73.935242);
      setUserDestinationLocation(target);
    } catch (e) {
      log(e.toString(), error: "User destination - getCurrentLocation");
    }
  }

  setUserDestinationLocation(LatLng value) {
    destinationPosition = value;
    setMapCameraPosition(destinationPosition!);
    setDestinationPositionAddress(value);
  }

  setMapCameraPosition(LatLng value) async {
    if (cameraInitialized == false) {
      initialMapCameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
      await setAnimation();
      cameraInitialized = true;
    }
    update();
  }

  setDestinationPositionAddress(LatLng value) async {
    destinationPositionAddress = await Utils.getAddressFromLatLng(
        value.latitude, value.longitude);
    locationController.text = destinationPositionAddress??"";

    update();
    //Get.put(UserHomeViewModel()).setDestinationPositionAddress(destinationPositionAddress ?? '');
    //Get.put(UserHomeViewModel()).setDestinationPositionAddress(destinationPositionAddress ?? '${UserSavedPlacesData.latitude} ${UserSavedPlacesData.longitude}');
  }

  setAnimation() async {
    Timer(Duration(seconds: 1), () async {
      final GoogleMapController _controller = await mapController.future;
      _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: destinationPosition!,
        zoom: 14,
      )));
      update();
    });
  }
  // Utils.showFloatingErrorSnack
  setCurrentPositionAddress(LatLng value) async {
    currentPositionAddress = await Utils.getAddressFromLatLng(
        value.latitude, value.longitude);
    latitude = value.latitude;
    longitude = value.longitude;
    print("CURRENT LATITUDE 2nd: ${value.latitude}");
    print("CURRENT LONGITUDE 2nd: ${value.longitude}");
    latitude = value.latitude;
    longitude = value.longitude;
    update();
  }
}
