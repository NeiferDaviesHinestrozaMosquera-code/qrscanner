import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrscanner/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapaScreen extends StatefulWidget {

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {

  Completer <GoogleMapController> _controller  = Completer();
  MapType mapType = MapType.normal; ///PARA PODER CAMBIAR  MAPAS


  @override
  Widget build(BuildContext context) {


    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel; ///SE HIZO UN CASTING
    
    final CameraPosition puntoInicial = CameraPosition(
    target: scan.getLatLng(), ///LLAMADO DESDE EL MODELO
    zoom: 17,
    tilt: 50 , ///GENERA GRADOS DE INCLINACION
    );
    //MARCADORES
    Set <Marker> markers = new Set <Marker>();
    markers.add(new Marker(
     position:scan.getLatLng(), 
     markerId: MarkerId('geo-location') ,
      ));
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text('Mapa Chingon'),
        actions: [ ///PARA REGRESAR A LA POSICION ORIGINAL
          IconButton(
            icon: Icon(Icons.local_activity),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: scan.getLatLng(),
                    zoom: 17,
                    tilt: 50 , ///GENERA GRADOS DE INCLINACION
                    )
                  )
               );
            },
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false, ///QUITA LA POSICION
        mapType: mapType, ///ESTILO DEL MAPA
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers_sharp),
      onPressed: () {
          if(mapType == MapType.normal){
            mapType = MapType.satellite;
          }
          
          else{
            mapType = MapType.normal;
          }
          
          
          setState(() {
            
          });
      },
    ),
   );
  }
}