import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:racconder/AdminSQLite/databaseAdmin.dart';
import 'package:racconder/Controladores/ControladorImagenes.dart';
import 'package:racconder/Entidades/EntidadProducto.dart';
import 'package:racconder/Home/HomePage.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:io';
import '../racconder_theme.dart';

class SeleccionarFecha extends StatefulWidget {
  @override
  _SeleccionarFechaState createState() => _SeleccionarFechaState();
}

class _SeleccionarFechaState extends State<SeleccionarFecha> {

  File imagen;
  bool banderaImagen = true;
  bool estadoFecha = true;

  DateTime fechaProducto;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController;
  TextEditingController _marcaController;
  TextEditingController _presentacionController;
  TextEditingController _descripcionController;
  TextEditingController _cantidadController;
  TextEditingController _duracionController;

  @override
  void initState() {
    fechaProducto = DateTime.now();
    // TODO: implement initState
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here

    setState(() {
      fechaProducto = args.value;
      print("FECHA: $fechaProducto");
    });

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: TemaRacconder.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Seleccionar Fecha'),
            IconButton(
              icon: Icon(
                Icons.check,
                size: 25,
              ),
              onPressed: () async {
                Navigator.pop(context, this.fechaProducto);
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: SfDateRangePicker(
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.single,
        ),
      ),
    );
  }
}