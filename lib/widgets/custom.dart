import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/ui_providers.dart';

class CustomNavigator extends StatelessWidget {
  const CustomNavigator({super.key});

  @override
  Widget build(BuildContext context) {

      final uiProvider = Provider.of<UiProviders>(context);

    final currenIndex = uiProvider.selectedMenuOpt;
    
    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      currentIndex: currenIndex,
      elevation: 0,
      items: <BottomNavigationBarItem>[
         BottomNavigationBarItem(
           icon: Icon(Icons.maps_home_work),
           label: 'Mapa Chingon'
           ),

            BottomNavigationBarItem(
           icon: Icon(Icons.compass_calibration_sharp),
           label: 'Direcciones Chingon'
           ),
      ]
    );
  }
}