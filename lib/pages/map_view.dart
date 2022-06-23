import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

import 'widgets/marker.dart';
import 'widgets/marker_popup.dart';
import '../state.dart';
import '../data/hospital_model.dart';

class MapView extends ConsumerStatefulWidget {
  MapView({Key? key, required this.list}) : super(key: key);
  final List<Hospital> list;

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends ConsumerState<MapView> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => ref.read(hospitalProvider.notifier).changeList(widget.list),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, watch, _) {
            final hospitals = ref.watch(hospitalProvider);
            final popupController = ref.watch(popupControllerProvider);

            return FlutterMap(
              options: MapOptions(
                center: LatLng(56.3, 10.5),
                zoom: 8,
                minZoom: 8,
                maxZoom: 18,
                nePanBoundary: LatLng(58.06239, 15.65449),
                swPanBoundary: LatLng(54.44065, 7.7011),
                slideOnBoundaries: true,
                screenSize: MediaQuery.of(context).size,
                boundsOptions: FitBoundsOptions(
                  zoom: 8,
                  maxZoom: 18,
                ),
                interactiveFlags: InteractiveFlag.drag |
                    InteractiveFlag.doubleTapZoom |
                    InteractiveFlag.flingAnimation |
                    InteractiveFlag.pinchZoom,
                plugins: [MarkerClusterPlugin()],
                onTap: (pos, _) => popupController.hideAllPopups(),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/jonasblendstrup/ckqceyefs01zl19p2rsq808t9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoiam9uYXNibGVuZHN0cnVwIiwiYSI6ImNrcWJmN3BiMDBxNmsyb3F0N2F2cHJnb2cifQ.g8_CZSKkwqRlmCCxZF77fg',
                  additionalOptions: {
                    'accessToken':
                        'pk.eyJ1Ijoiam9uYXNibGVuZHN0cnVwIiwiYSI6ImNrcWJmN3BiMDBxNmsyb3F0N2F2cHJnb2cifQ.g8_CZSKkwqRlmCCxZF77fg',
                    'id': 'mapbox.mapbox-streets-v8'
                  },
                ),
                MarkerClusterLayerOptions(
                  maxClusterRadius: 80,
                  size: Size(40, 40),
                  disableClusteringAtZoom: 9,
                  fitBoundsOptions: FitBoundsOptions(
                    padding: EdgeInsets.all(80),
                  ),
                  markers: hospitals
                      .where((doc) => doc.enabled == true)
                      .toList()
                      .map((hospital) => HospitalMarker(hospital: hospital))
                      .toList(),
                  polygonOptions: PolygonOptions(
                    borderColor: Colors.blueAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 3,
                  ),
                  builder: (context, markers) {
                    return FloatingActionButton(
                      heroTag: markers.first.key,
                      child: Text(markers.length.toString()),
                      onPressed: null,
                    );
                  },
                  popupOptions: PopupOptions(
                    popupSnap: PopupSnap.markerTop,
                    popupController: popupController,
                    popupBuilder: (_, marker) {
                      if (marker is HospitalMarker)
                        return HospitalMarkerPopup(hospital: marker.hospital);

                      return Card(child: const Text('Marker popup = :('));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
