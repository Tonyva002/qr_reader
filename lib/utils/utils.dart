
import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrls(BuildContext context, ScanModel scan) async {
  final Uri _url = Uri.parse(scan.value);
  if(scan.type == 'http'){
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}