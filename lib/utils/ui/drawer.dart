import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/racconder_theme.dart';

class DrawerView extends StatefulWidget{

  @override
  _DrawerViewScreen createState() => _DrawerViewScreen();
}

class _DrawerViewScreen extends State<DrawerView> {

  TextStyle estiloOpciones = TextStyle(
    color: Colors.black,
    fontSize: 25.0,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        // Important: Remove any padding from the ListView.
        //padding: EdgeInsets.zero,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: TemaRacconder.primaryColor,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 1,
                  right: 1,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                //Text('Racconder'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      image: AssetImage('assets/imagenes/racconder_logo.png'),
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Racconder',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Inicio',
                    style: estiloOpciones,
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'recordatorios',
                    style: estiloOpciones,
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'productos',
                    style: estiloOpciones,
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'servicios',
                    style: estiloOpciones,
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: TemaRacconder.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Configuración',
                  style: TextStyle(
                    fontFamily: TemaRacconder.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: TemaRacconder.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.miscellaneous_services,
                  color: Colors.black,
                ),
                onTap: null,
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }
}