import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_model.freezed.dart';

@freezed
class LocationModel with _$LocationModel{
  factory LocationModel({
    required double lat,
    required double lon,
    required double speed
  }) =_LocationModel;
}

@freezed
class LocationState with _$LocationState{
  factory LocationState({
    required List<LocationModel> location,
    required Timer? timer,
  }) = _LocationState;
}