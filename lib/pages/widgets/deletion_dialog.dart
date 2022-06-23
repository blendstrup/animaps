import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/hospital_model.dart';
import '../../state.dart';

void showAppDialog(
    WidgetRef ref, BuildContext context, Hospital hospital) async {
  if (Platform.isAndroid) {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Slet?'),
        content: Text('Er du sikker på at du vil slette ${hospital.title}?'),
        actions: [
          TextButton(
            child: Text('Nej'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Ja'),
            onPressed: () => onPressedDialog(ref, context, hospital),
          ),
        ],
      ),
    );
  } else if (Platform.isIOS) {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Slet?'),
        content: Text('Er du sikker på at du vil slette ${hospital.title}?'),
        actions: [
          CupertinoDialogAction(
            child: Text('Nej'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: Text('Ja'),
            onPressed: () => onPressedDialog(ref, context, hospital),
          ),
        ],
      ),
    );
  }
}

void onPressedDialog(WidgetRef ref, BuildContext context, Hospital hospital) {
  final popupController = ref.read(popupControllerProvider);

  FirebaseFirestore.instance
      .collection('animal-hospitals')
      .doc(hospital.documentID)
      .update({'enabled': false});

  ref.read(hospitalProvider.notifier).toggle(hospital);
  popupController.hideAllPopups();

  Navigator.popUntil(context, (route) {
    return route.settings.name == "/";
  });
}
