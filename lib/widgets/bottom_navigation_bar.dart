import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    return BottomNavigationBar(
      onTap: (int i ) => uiProvider.selectedMenuOpt = i,
      currentIndex: uiProvider.selectedMenuOpt,
      elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'MAP'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration_outlined),
              label: 'URL'
          ),

    ]);
  }
}
