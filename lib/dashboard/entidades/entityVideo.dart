import 'dart:io';


class EntityVideo{
  int idVideo;
   String pathVideo;
   int anio;
   int mes;
   int dia;
   int idMomento;
   int idHistoria;
   bool _seleccionado=false;
 EntityVideo(this.pathVideo, this.idMomento, this.idHistoria, this.anio, this.mes, this.dia);


  bool get seleccionado => _seleccionado;

  set seleccionado(bool value) {
    _seleccionado = value;
  }

  EntityVideo.fromMap(Map<String, dynamic> map){
    idVideo= map['idVideo'];
    pathVideo=map['pathVideo'];
    anio=map['anio'];
    mes=map['mes'];
    dia=map['dia'];
    idMomento = map['idMomento'];
    idHistoria =map['idHistoria'];
  }

  Map<String, dynamic> toMap(){
    return{
      "idVideo":idVideo,
      "pathVideo":pathVideo,
      "anio":anio,
      "mes":mes,
      "dia":dia,
      "idMomento":idMomento,
      "idHistoria":idHistoria
    };
  }
}