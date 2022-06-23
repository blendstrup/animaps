import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum InfoType { web, phone, address }

class InfoArea extends StatelessWidget {
  const InfoArea({
    Key? key,
    required this.text,
    required this.title,
    required this.type,
  }) : super(key: key);

  final String text;
  final String title;
  final InfoType type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 5),
          if (text != 'Add website')
            SelectableText(
              (text != '') ? text : 'Ikke fundet :(',
              style: (type == InfoType.web || type == InfoType.phone)
                  ? Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.blue)
                  : Theme.of(context).textTheme.bodyText1,
              onTap: () async =>
                  (type != InfoType.address && text != 'Add website')
                      ? launchUrl()
                      : null,
            )
          else
            Text(
              'Ikke fundet :(',
              style: Theme.of(context).textTheme.bodyText1,
            ),
        ],
      ),
    );
  }

  Future<bool> launchUrl() async {
    String url = '';

    if (type == InfoType.phone) url = 'tel:$text';
    if (type == InfoType.web) url = 'http://$text';

    return await canLaunch(url)
        ? await launch(url)
        : throw 'Could not launch $url';
  }
}
