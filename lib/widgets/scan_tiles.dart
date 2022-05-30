

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list.dart';
import 'package:qrscanner/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  

  final String tipo;

  const ScanTiles({required this.tipo});

  @override
  Widget build(BuildContext context) {
   final scanListProvider = Provider.of<ScanList>(context);
   final scans = scanListProvider.scans; 

    return ListView.builder(
      itemBuilder: (_,i) => Dismissible( //GENERA  LLAVES UNICAS DIRECTO DE FLUTTER
        key: UniqueKey(), //GENERA  LLAVES UNICAS DIRECTO DE FLUTTER
        background: Container(
          color: Colors.red,
        ),
        onDismissed:(DismissDirection direction) {
          Provider.of<ScanList>(context , listen: false).borrarScanPorId(scans[i].id!); ///SE AGREGO UN !
        },
        child: ListTile(
         
          leading: Icon(
             this.tipo == 'http' ///CONDICIONAL PARA NO DEBIDO A LA CREACION DEL WIDGET TILES
              ? Icons.home_outlined ///CONDICIONAL PARA NO DEBIDO A LA CREACION DEL WIDGET TILES
              : Icons.map_outlined,   ///CONDICIONAL PARA NO DEBIDO A LA CREACION DEL WIDGET TILES
          color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].valor),
          subtitle: Text(scans[i].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right ,  color: Colors.grey,),
          onTap: () => launchUrl(scans [i], context),
        ),
      ),
      itemCount:scans.length,);
  }
} 