import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io' show Platform;

import '../../data/hospital_model.dart';
import '../../state.dart';

import 'widgets/info_area.dart';
import 'widgets/deletion_dialog.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({required this.hospital});

  final Hospital hospital;

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    if (widget.hospital.notes != '') controller.text = widget.hospital.notes;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: () => pagePop(
                ref,
                context,
                controller,
                widget.hospital,
              ),
              icon: (Platform.isIOS)
                  ? Icon(Icons.arrow_back_ios_new)
                  : Icon(Icons.arrow_back),
              color: Colors.black,
              splashRadius: 20,
            );
          }),
          actions: [
            Consumer(builder: (context, ref, child) {
              return IconButton(
                onPressed: () => showAppDialog(
                  ref,
                  context,
                  widget.hospital,
                ),
                icon: Icon(Icons.delete),
                color: Colors.black,
                splashRadius: 20,
              );
            }),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Center(
              child: Text(
                widget.hospital.title,
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoArea(
                  title: 'Adresse',
                  text: widget.hospital.address,
                  type: InfoType.address,
                ),
                InfoArea(
                  title: 'Telefon',
                  text: widget.hospital.phone,
                  type: InfoType.phone,
                ),
                InfoArea(
                  title: 'Hjemmeside',
                  text: widget.hospital.website,
                  type: InfoType.web,
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Noter',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Card(
              elevation: 0,
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.newline,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Skriv dine noter her...',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

void pagePop(
  WidgetRef ref,
  BuildContext context,
  TextEditingController controller,
  Hospital hospital,
) {
  if (controller.text != hospital.notes) {
    final popupController = ref.read(popupControllerProvider);

    FirebaseFirestore.instance
        .collection('animal-hospitals')
        .doc(hospital.documentID)
        .update({'notes': controller.text});

    ref.read(hospitalProvider.notifier).editNotes(
          hospital: hospital,
          notes: controller.text,
        );

    var marker = popupController.selectedMarkers;
    popupController.togglePopup(marker.first);
  }

  Navigator.of(context).pop();
}
