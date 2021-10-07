import 'package:flutter/material.dart';
import 'package:racconder/main.dart';
import 'package:racconder/racconder_theme.dart';
import 'package:racconder/Productos/agregarProducto.dart';
import 'package:racconder/Recordatorios/agregarRecordatorio.dart';
import 'package:racconder/Servicios/agregarServicio.dart';

class BotonExpandible extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

  BotonExpandible({this.onPressed, this.tooltip, this.icon});

  @override
  _BotonExpandibleState createState() => _BotonExpandibleState();
}

class _BotonExpandibleState extends State<BotonExpandible>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: TemaRacconder.primaryColor,
      end: TemaRacconder.wrongColor,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget recordatorios() {
    return Container(
      child: FloatingActionButton(
        heroTag: "agregarRecordatorio",
        backgroundColor: HexColor('#00caff'),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgregarRecordatorio()),
          );
        },
        tooltip: 'Recordatorios',
        child: Icon(Icons.more_time),
      ),
    );
  }

  Widget productos() {
    return Container(
      child: FloatingActionButton(
        heroTag: "agregarProducto",
        backgroundColor: HexColor('#00caff'),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgregarProducto()),
          );
        },
        tooltip: 'Productos',
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }

  Widget servicios() {
    return Container(
      child: FloatingActionButton(
        heroTag: "agregarServicio",
        backgroundColor: HexColor('#00caff'),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AgregarServicio()),
          );
        },
        tooltip: 'Servicios',
        child: Icon(Icons.add_business),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: recordatorios(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: productos(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: servicios(),
        ),
        toggle(),
      ],
    );
  }
}