import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/pages/direccionesdev.dart';
import 'package:qrscanner/pages/mapasdev.dart';
import 'package:qrscanner/providers/db_provider.dart';
import 'package:qrscanner/providers/scan_list.dart';
import 'package:qrscanner/providers/ui_providers.dart';
import 'package:qrscanner/widgets/custom.dart';
import 'package:qrscanner/widgets/scan_button.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        elevation: 0,
        centerTitle: true,
        title: Text('Historial'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: (){
                final scanListProvider = Provider.of<ScanList>(context , listen: false); ///VA EN FALSE PARA QUE NO SE REDIBJE 
                scanListProvider.borrarTodos();
            }, 
            icon: Icon(Icons.delete_forever_sharp)
            ),
        ],
        ),
      body: _HomePageBody(),
     bottomNavigationBar:CustomNavigator() ,
     floatingActionButton: ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  }
}

class _HomePageBody extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {

    //OBTENER EL SELECT MENU OP
  final uiProvider = Provider.of<UiProviders>(context);

  ///CAMBIO DE PAGINAS
  final currenIndex = uiProvider.selectedMenuOpt;


  //USAR EL SCANLISTPROVIDER 
  final scanListProvider = Provider.of<ScanList>(context , listen: false);

    switch(currenIndex) {

      case 0:
      scanListProvider.cargarScanPorTipo('geo');
      return MapasDevPage();

       case 1:
       scanListProvider.cargarScanPorTipo('http');
      return DireccionesDevPage();

      default: 
      return MapasDevPage();
    }
  }
}