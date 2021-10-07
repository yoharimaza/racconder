import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racconder/drawer.dart';
import '../racconder_theme.dart';
import 'dart:io';

class AgregarServicio extends StatefulWidget {
  @override
  _AgregarServicioState createState() => _AgregarServicioState();
}

class _AgregarServicioState extends State<AgregarServicio> {

  File imagen;

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
        backgroundColor: TemaRacconder.primaryColor, //business
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Agregar Servicio',
            ),
            Icon(
              Icons.add_business,
              size: 30,
            ),
          ],
        ),
      ),
      body: mostrarServicios(),
    );
  }

  mostrarServicios(){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                color: Colors.blue,
                child: (imagen != null) ?
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    imagen,
                    width: 250,
                    height: 250,
                    fit: BoxFit.fitWidth,
                    //fit: Image.file(imageFile).width  Image.file(imageFile).height ? BoxFit.fitHeight : BoxFit.fitWidth
                  ),
                )
                    :
                IconButton(icon: Icon(Icons.add_a_photo), onPressed: null),
              ),
              Text(
                '¡No hay nada aquí!',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}