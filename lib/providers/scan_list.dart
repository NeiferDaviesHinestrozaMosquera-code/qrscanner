

import 'package:flutter/material.dart';
import 'package:qrscanner/providers/db_provider.dart';

class ScanList extends ChangeNotifier{

  List <ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future <ScanModel> nuevoScan (String valor) async{
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //  ASIGNAR EL ID A LA BASE DE DATOS EN EL MODELO
    nuevoScan.id = id;
    if (this.tipoSeleccionado == nuevoScan.tipo) {
       this.scans.add(nuevoScan);
        notifyListeners(); ///PARA LOS CAMBIO 
    }
   return nuevoScan;
  }
  cargarScans() async{
      final scans = await DBProvider.db.getTodosLosScans();
      this.scans = [...scans];
      notifyListeners();
  }

  cargarScanPorTipo(String tipo) async{
 final scans = await DBProvider.db.getScansPorTipo(tipo);
      this.scans = [...scans];
      this.tipoSeleccionado = tipo;
      notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    this.cargarScanPorTipo(this.tipoSeleccionado);
  
  }
  
  borrarTodos() async{
     await DBProvider.db.deleteAllScans();
     this.scans = [];
     notifyListeners();
  }



}