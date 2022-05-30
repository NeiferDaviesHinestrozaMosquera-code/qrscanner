import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/providers/scan_list.dart';
import 'package:qrscanner/widgets/scan_tiles.dart';

class MapasDevPage extends StatelessWidget {
  const MapasDevPage({super.key});

  @override
  Widget build(BuildContext context) {

   return ScanTiles(tipo: 'geo');
  }
}