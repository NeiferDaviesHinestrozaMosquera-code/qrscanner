import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list.dart';
import 'package:qrscanner/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: ()async {
      
             
            String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);

             ///final barcodeScanRes = 'geo:5.35,-72.4';

             if(barcodeScanRes == '-1'){
               return;
             }

            final scanListProvider = Provider.of<ScanList>(context , listen: false);

            final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
            
            launchUrl(nuevoScan, context);
      }
    );
  }
}