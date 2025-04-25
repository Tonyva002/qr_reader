import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/bottom_navigation_bar.dart';
import 'package:qr_reader/widgets/floating_action_button.dart';
import 'package:qr_reader/widgets/scan_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Codigos QR',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: () {
              final scanProvider = Provider.of<ScanProvider>(
                context,
                listen: false,
              );
              scanProvider.deleteAll();
            },
            icon: Icon(Icons.delete_forever),
            color: Colors.white,
          ),
        ],
      ),
      body: _HomePageBody(),

      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    // Usar el ScanProvider
    final scanProvider = Provider.of<ScanProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanProvider.loadScanForType('geo');
        return ScanList(type: 'geo');

      case 1:
        scanProvider.loadScanForType('http');
        return ScanList(type: 'http');

      default:
        return ScanList(type: 'geo');
    }
  }
}
