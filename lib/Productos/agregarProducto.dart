import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:racconder/AdminSQLite/databaseAdmin.dart';
import 'package:racconder/Controladores/ControladorImagenes.dart';
import 'package:racconder/Entidades/EntidadProducto.dart';
import 'package:racconder/Home/HomePage.dart';
import 'package:intl/intl.dart';
import 'package:racconder/VistasEstandar/SeleccionarFecha.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:io';
import '../racconder_theme.dart';

class AgregarProducto extends StatefulWidget {
  @override
  _AgregarProductoState createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProducto> {

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
    _nombreController = TextEditingController();
    _marcaController = TextEditingController();
    _presentacionController = TextEditingController();
    _descripcionController = TextEditingController();
    _cantidadController = TextEditingController();
    _duracionController = TextEditingController();
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here
    /*
    setState(() {
      fechaProducto = args.value;
    });
     */
  }

  void seleccionarFecha(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("Aceptar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atención"),
      content: Container(
        width: MediaQuery.of(context).size.width * (9/10),
        height: MediaQuery.of(context).size.height * (7/10),
        color: Colors.white,
        child: SfDateRangePicker(
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.single,
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void mostrarOpcionesSeleccionarImagen(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Desde Galeria'),
                      onTap: () async {
                        File imagen = await ControladorImagenes().desdeGaleria();
                        setState(() {
                          this.imagen = imagen;
                          this.banderaImagen = true;
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Tomar Foto'),
                    onTap: () async {
                      File imagen = await ControladorImagenes().desdeCamara();
                      setState(() {
                        this.imagen = imagen;
                        this.banderaImagen = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
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
            Text('Agregar Producto'),
            IconButton(
              icon: Icon(
                Icons.save,
                size: 25,
              ),
              onPressed: () async {
                if (_formKey.currentState.validate() && imagen!=null) {
                  DatabaseAdmin admin = DatabaseAdmin();
                  await admin.initDatabase();
                  EntidadProducto entidadProducto = EntidadProducto(_nombreController.text, _marcaController.text, _presentacionController.text, _descripcionController.text, int.parse(_cantidadController.text), int.parse(_duracionController.text), this.imagen.path);
                  int idProducto = await admin.insertarProducto(entidadProducto);
                  print("ID de Producto agregado: $idProducto");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: 'Racconder')),
                  );
                }else{
                  if(imagen == null){
                    setState(() {
                      banderaImagen = false;
                    });
                  }else{
                    setState(() {
                      banderaImagen = true;
                    });
                  }
                }
              },
            ),
          ],
        ),
      ),
      body: formAgregarProducto(),
    );
  }

  formAgregarProducto(){
    return Container(
      width: MediaQuery.of(context).size.width,
      //color: Colors.green,
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10,bottom: 10,top: 20),
                    child: Container(
                      width: 150,
                      height: 150,
                      //color: Colors.blue,
                      child: Stack(
                        children: [
                          (imagen != null) ?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              this.imagen,
                              width: 150,
                              height: 150,
                              fit: BoxFit.fitWidth,
                              //fit: Image.file(imageFile).width  Image.file(imageFile).height ? BoxFit.fitHeight : BoxFit.fitWidth
                            ),
                          )
                              :
                          CircleAvatar(
                            radius: 100,
                            backgroundColor: (banderaImagen==true) ? Colors.black : TemaRacconder.wrongColor,
                            child: IconButton(
                              icon: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: (){
                                mostrarOpcionesSeleccionarImagen(context);
                              },
                              iconSize: 100,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Visibility(
                              visible: (imagen != null) ? true : false,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: (banderaImagen==true) ? Colors.black : TemaRacconder.wrongColor,
                                child: IconButton(
                                  icon: Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: (){
                                    mostrarOpcionesSeleccionarImagen(context);
                                  },
                                  iconSize: 40,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20, bottom: 10),
                    child: TextFormField(
                      controller: _nombreController,
                      decoration: InputDecoration(
                        labelText: '* Nombre del Producto',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (String value) {
                        if(value.isNotEmpty){
                          return null;
                        }else{
                          return 'Debe ingresar un nombre';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*(2/5),
                          child: TextFormField(
                            controller: _marcaController,
                            decoration: InputDecoration(
                              labelText: 'Marca',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*(2/5),
                          child: TextFormField(
                            controller: _presentacionController,
                            decoration: InputDecoration(
                              labelText: 'Presentación',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20, bottom: 10),
                    child: TextFormField(
                      maxLines: 1,
                      controller: _descripcionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width*(2/7),
                          child: TextFormField(
                            controller: _cantidadController,
                            decoration: InputDecoration(
                              labelText: '* Cantidad',
                              border: UnderlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            validator: (String value) {
                              if(value.isNotEmpty){
                                return int.parse(value)>0?null:'Especifique';
                              }else{
                                return 'Especifique';
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*(4/7),
                          child: TextFormField(
                            controller: _duracionController,
                            decoration: InputDecoration(
                              labelText: '* Duración en días de C/U',
                              border: UnderlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            validator: (String value) {
                              if(value.isNotEmpty){
                                return int.parse(value)>0?null:'Especifique';
                              }else{
                                return 'Especifique';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Desde: '
                            ),
                            Row(
                              children: [
                                Text(
                                    'Hoy'
                                ),
                                Switch(
                                  value: estadoFecha,
                                  onChanged: (value) {
                                    setState(() {
                                      estadoFecha = value;
                                      print(estadoFecha);
                                    });
                                  },
                                  activeTrackColor: Colors.yellow,
                                  activeColor: Colors.orangeAccent,
                                )
                              ],
                            )
                          ],
                        ),
                        Material(
                          child: InkWell(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                // Create the SelectionScreen in the next step.
                                MaterialPageRoute(builder: (context) => SeleccionarFecha()),
                              );

                              print("FECHA SELECCIONADA DE LA PANTALLA: $result");
                            },
                            child: Row(
                              children: [
                                Text(
                                    '${DateFormat('dd / MM / yyyy').format(fechaProducto)}'
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            /*
            Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {

                    if (_formKey.currentState.validate() && imagen!=null) {

                    }else{
                      setState(() {
                        banderaImagen = false;
                      });
                    }

                  },
                  child: const Text('Guardar'),
                ),
              ),
            ),
             */
          ],
        ),
      ),
    );
  }
}