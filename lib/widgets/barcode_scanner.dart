import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/scan_provider.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({super.key});

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  final MobileScannerController controller = MobileScannerController();
  bool isScanned = false;

  void _handleBarcode(BarcodeCapture barcodes) async {
    if (isScanned || barcodes.barcodes.isEmpty) return;

    // Usar el ScanProvider
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);


    final barcode = barcodes.barcodes.first;
    final String? code = barcode.rawValue;

    if (code != null && mounted) {
      if(code == '-1'){
        return;
      }
      final newScan = await scanProvider.newScan(code);
      isScanned = true;
      controller.stop(); // Opcional: detener el escáner
      Navigator.pop(context, code); // Devolver el resultado
      launchUrls(context, newScan);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Scanner')),
      body: MobileScanner(controller: controller, onDetect: _handleBarcode),
    );
  }
}

