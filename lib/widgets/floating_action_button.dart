import 'package:flutter/material.dart';

import 'barcode_scanner.dart';


class FloatingActButton extends StatelessWidget {
  const FloatingActButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
        child: Icon(Icons.filter_center_focus),
        onPressed: (){

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BarcodeScanner()),
          );


        }
    );
  }
}
