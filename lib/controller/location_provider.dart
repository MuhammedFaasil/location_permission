import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:location_permission/model/location_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';



part 'location_provider.g.dart';

@riverpod
class Location extends _$Location {
  @override
  LocationState build() {
   return LocationState(location: [], timer: null);
  }
   Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition();
  }

  /// Start polling
  Future<void> startLocationPolling() async {
    /// If any timer already exists, then do nothing
    if (state.timer != null) {
      return;
    }

    final timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      final newLocation = await _getCurrentLocation();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('latitude', newLocation.latitude);
      prefs.setDouble('longitude', newLocation.longitude);
      state = state.copyWith(
        location: [
          ...state.location,
          LocationModel(
            lat: newLocation.latitude,
            lon: newLocation.longitude,
            speed: newLocation.speed,
          )
        ],
      );

      print(state.location);
    });

    state = state.copyWith(timer: timer);
  }

  void stopLocationPolling() {
    if (state.timer != null) {
      state.timer!.cancel();
      state = state.copyWith(timer: null);
    }
  }
}
