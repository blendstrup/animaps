import 'package:riverpod/riverpod.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'data/hospital_model.dart';

final popupControllerProvider =
    Provider<PopupController>((ref) => PopupController());

final hospitalProvider =
    StateNotifierProvider<HospitalList, List<Hospital>>((ref) {
  return HospitalList([]);
});

class HospitalList extends StateNotifier<List<Hospital>> {
  HospitalList([List<Hospital>? initialHospitals])
      : super(initialHospitals ?? []);

  void changeList(List<Hospital> list) => state = list;

  void changeColor({required Hospital hospital, required int color}) {
    state = [
      for (final hospitals in state)
        if (hospitals.documentID == hospital.documentID)
          hospital.copyWith(iconColor: color)
        else
          hospitals,
    ];
  }

  void toggle(Hospital hospital) {
    state = [
      for (final hospitals in state)
        if (hospitals.documentID == hospital.documentID)
          hospital.copyWith(enabled: !hospital.enabled)
        else
          hospitals,
    ];
  }

  void editNotes({required Hospital hospital, required String notes}) {
    state = [
      for (final hospitals in state)
        if (hospitals.documentID == hospital.documentID)
          hospital.copyWith(notes: notes)
        else
          hospitals,
    ];
  }
}
