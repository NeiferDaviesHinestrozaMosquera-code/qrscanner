import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscanner/pages/home_page.dart';
import 'package:qrscanner/pages/mapa_page.dart';
import 'package:qrscanner/providers/scan_list.dart';
import 'package:qrscanner/providers/ui_providers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      
      providers: [ChangeNotifierProvider
      (
        create: (_) => new UiProviders() 
      ),
      ChangeNotifierProvider
      (
        create: (_) => new ScanList() 
      )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qr App',
        initialRoute: 'home',
        routes: {
          'home' :(_) => HomeScreen() ,
          'mapa' :(_) => MapaScreen() ,
        },
        theme: ThemeData(
          primaryColor: Colors.orange,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.orange
          )
        ),
      ),
    );

  }
}