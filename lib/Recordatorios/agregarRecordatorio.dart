import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racconder/drawer.dart';

import '../racconder_theme.dart';

class AgregarRecordatorio extends StatefulWidget {
  @override
  _AgregarRecordatorioState createState() => _AgregarRecordatorioState();
}

class _AgregarRecordatorioState extends State<AgregarRecordatorio> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TemaRacconder.primaryColor,
        title: Text('Agregar Recordatorio'),
      ),
      body: mostrarRecordatorios(),
    );
  }

  mostrarRecordatorios(){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.apartment_rounded,
            size: 180,
          ),
          Text(
            '¡No hay nada aquí!',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}