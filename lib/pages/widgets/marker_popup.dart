import 'package:flutter/material.dart';

import '../../data/hospital_model.dart';
import '../info_page.dart';
import 'color_button.dart';

class HospitalMarkerPopup extends StatelessWidget {
  const HospitalMarkerPopup({
    Key? key,
    required this.hospital,
  }) : super(key: key);

  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 300,
          padding: const EdgeInsets.only(bottom: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            color: Colors.white.withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10),
                  Text(
                    hospital.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ColorButton(
                        color: Colors.red[400],
                        hospital: hospital,
                      ),
                      ColorButton(
                        color: Colors.orange[400],
                        hospital: hospital,
                      ),
                      ColorButton(
                        color: Colors.yellow[400],
                        hospital: hospital,
                      ),
                      ColorButton(
                        color: Colors.green[400],
                        hospital: hospital,
                      ),
                      ColorButton(
                        color: Colors.blue[400],
                        hospital: hospital,
                      ),
                      ColorButton(
                        color: Colors.purple[400],
                        hospital: hospital,
                      ),
                      ColorButton(
                        color: Colors.black,
                        hospital: hospital,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                label: Text(
                  'Mere information',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.black87),
                ),
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black87,
                ),
                elevation: 2,
                highlightElevation: 4,
                backgroundColor: Colors.white.withOpacity(0.9),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return InfoPage(hospital: hospital);
                  }),
                ),
              ),
            ],
          ),
          right: 0,
          left: 0,
          bottom: 0,
        ),
      ],
    );
  }
}
