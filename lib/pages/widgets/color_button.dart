import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../state.dart';
import '../../data/hospital_model.dart';

class ColorButton extends ConsumerWidget {
  const ColorButton({
    Key? key,
    required this.color,
    required this.hospital,
  }) : super(key: key);

  final Color? color;
  final Hospital hospital;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref
            .read(hospitalProvider.notifier)
            .changeColor(hospital: hospital, color: color!.value);
        FirebaseFirestore.instance
            .collection('animal-hospitals')
            .doc(hospital.documentID)
            .update({'iconColor': color!.value});
      },
      child: Material(
        elevation: 2,
        shape: CircleBorder(),
        color: color,
        child: Container(
          height: 30,
          width: 30,
        ),
      ),
    );
  }
}
