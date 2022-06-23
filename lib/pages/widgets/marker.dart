import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../data/hospital_model.dart';

import 'marker_icon.dart';

class HospitalMarker extends Marker {
  HospitalMarker({required this.hospital})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: 30,
          width: 30,
          point: LatLng(
            double.tryParse(hospital.latitude) ?? 0,
            double.tryParse(hospital.longitude) ?? 0,
          ),
          builder: (BuildContext ctx) => HospitalMarkerIcon(hospital: hospital),
          key: ValueKey(hospital.documentID),
        );

  final Hospital hospital;
}
