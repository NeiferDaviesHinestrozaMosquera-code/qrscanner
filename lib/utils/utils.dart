import 'package:flutter/cupertino.dart';
import 'package:qrscanner/models/scan_models.dart';
import 'package:url_launcher/url_launcher.dart';

launchUrl(ScanModel scan , BuildContext context) async {
  final url = scan.valor;

  if(scan.tipo == 'http'){
    if(!await launch(url)) throw 'Could not launche $url';
   //if (!await launchUrl(url)) throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}