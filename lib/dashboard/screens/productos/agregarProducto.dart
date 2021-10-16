import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:racconder/main.dart';
import 'package:racconder/utils/services/adminSQLite/databaseAdmin.dart';
import 'package:racconder/dashboard/controladores/controladorImagenes.dart';
import 'package:racconder/dashboard/entidades/entidadProducto.dart';
import 'package:racconder/dashboard/screens/home/homePage.dart';
import 'package:intl/intl.dart';
import 'package:racconder/utils/ui/seleccionarFecha.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:io';
import 'package:racconder/config/racconder_theme.dart';

class AgregarProducto extends StatefulWidget {
  @override
  _AgregarProductoState createState() => _AgregarProductoState();
}

class _AgregarProductoState extends State<AgregarProducto> {

  File imagen;
  bool banderaImagen = true;
  bool usarFechaActual = true;

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
          ],
        ),
      ),
      body: formAgregarProducto(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TemaRacconder.primaryColor,
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
        child: Icon(
          Icons.save,
          size: 25,
        ),
      ),
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
                  Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Desde: Hoy'
                            ),
                            Switch(
                              value: usarFechaActual,
                              onChanged: (value) {
                                setState(() {
                                  usarFechaActual = value;
                                  if(usarFechaActual){
                                    this.fechaProducto = DateTime.now();
                                  }
                                });
                              },
                              activeTrackColor: TemaRacconder.clearPrimaryColor,
                              activeColor: TemaRacconder.primaryColor,
                            ),

                            Material(
                              child: InkWell(
                                onTap: () async {
                                  if(!this.usarFechaActual){
                                    print("FECHA ACTUAL: $fechaProducto");
                                    final result = await Navigator.push(
                                      context,
                                      // Create the SelectionScreen in the next step.
                                      MaterialPageRoute(builder: (context) => SeleccionarFecha()),
                                    );

                                    if(result != null){
                                      print("FECHA SELECCIONADA DE LA PANTALLA: $result");
                                      setState(() {
                                        this.fechaProducto = result;
                                      });
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        '${DateFormat('dd / MM / yyyy').format(fechaProducto)}',
                                      style: TextStyle(
                                        color: (this.usarFechaActual)? Colors.black26 : Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.edit,
                                      color: (this.usarFechaActual)? Colors.black26 : TemaRacconder.secondaryColor,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
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