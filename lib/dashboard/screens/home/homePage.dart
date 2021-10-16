import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:racconder/utils/services/adminSQLite/databaseAdmin.dart';
import 'package:racconder/dashboard/entidades/entidadProducto.dart';
import 'package:racconder/utils/ui/drawer.dart';
import 'dart:io';
import 'package:racconder/utils/ui/botonExpandible.dart';
import 'package:racconder/config/racconder_theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  DatabaseAdmin admin = DatabaseAdmin();

  List<EntidadProducto> listaProductos = [];

  bool obteniendoListaProductos = true;

  obtenerTodosProductos() async {
    await admin.initDatabase();
    List<EntidadProducto> lista = await admin.obtenerTodosProductos();
    if(lista.isNotEmpty){
      setState(() {
        this.listaProductos = lista;
        obteniendoListaProductos = false;
      });
    }else{
      setState(() {
        obteniendoListaProductos = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    obtenerTodosProductos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: TemaRacconder.primaryColor,
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Recordatorios'),
                  Tab(text: 'Productos'),
                  Tab(text: 'Servicios'),
                ],
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                mostrarRecordatorios(),
                mostrarProductos(),
                mostrarServicios(),
              ],
            ),
            drawer: DrawerView(

            ),
            floatingActionButton: BotonExpandible(),
          ),
        )
    );
  }

  mostrarRecordatorios(){
    return Container(
      //color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time,
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

  mostrarProductos(){
    return (this.obteniendoListaProductos == true) ?
    (
        Container(
          //color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: TemaRacconder.primaryColor,
              ),
              Text(
                'Cargando',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
        )
    )
    :
    (
        (this.listaProductos.isEmpty) ?
        (
            Container(
              //color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
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
            )
        )
        :
        (
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                        itemCount: this.listaProductos.length,
                        itemBuilder: (context, index) {
                          //print("INDEX: $index / ${listaProductos[index].nombreProducto}");
                          return cardProducto(listaProductos[index]);
                        },
                    ),
                  ),
                ],
              ),
            )
        )
    )
    ;
  }

  mostrarServicios(){
    return Container(
      //color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business,
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

  cardProducto(EntidadProducto producto){
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            color: TemaRacconder.chipBackground,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 15.0)
              ),
            ]
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.file(
                    File(producto.rutaImagen),
                    width: MediaQuery.of(context).size.width*(2/7),
                    height: MediaQuery.of(context).size.width*(2/7),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*(4/7),
                ///color: Colors.green,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nombre: ${producto.nombreProducto}',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Marca: ${producto.marcaProducto}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      'Descripción: ${producto.descripcionProducto}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Restante: ${producto.cantidadProducto}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Duración C/U: ${producto.duracionProducto}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}