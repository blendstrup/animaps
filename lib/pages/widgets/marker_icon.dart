import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state.dart';
import '../../data/hospital_model.dart';

class HospitalMarkerIcon extends ConsumerWidget {
  HospitalMarkerIcon({Key? key, required this.hospital}) : super(key: key);

  final Hospital hospital;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Hospital watchedHospital =
        ref.watch(hospitalProvider)[int.parse(hospital.documentID)];

    return Container(
      child: Icon(
        Icons.place,
        size: 30,
        color: Color(watchedHospital.iconColor),
      ),
    );
  }
}
