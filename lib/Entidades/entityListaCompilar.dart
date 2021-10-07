import 'dart:io';

class EntityListaCompilar{
  int idCompilar;
  int idVideo;
  int idHistoria;
  EntityListaCompilar(this.idVideo,this.idHistoria,);

  EntityListaCompilar.fromMap(Map<String, dynamic> map){
    idCompilar= map['idCompilar'];
    idVideo= map['idVideo'];
    idHistoria =map['idHistoria'];
  }

  Map<String, dynamic> toMap(){
    return{
      "idCompilar":idCompilar,
      "idVideo":idVideo,
      "idHistoria":idHistoria
    };
  }
}