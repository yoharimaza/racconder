
 class EntityMomento{
   int idMomento;
   String nombreMomento;
   String pathMomento;
   String colorMomento;
   int isPredeterminado;

  EntityMomento(this.nombreMomento, this.pathMomento, this.colorMomento, this.isPredeterminado);

  EntityMomento.fromMap(Map<String, dynamic> map){
    idMomento = map['idMomento'];
    nombreMomento = map['nombreMomento'];
    pathMomento = map['pathMomento'];
    colorMomento = map['colorMomento'];
    isPredeterminado = map['isPredeterminado'];
  }


  Map<String, dynamic> toMap(){
    return{
      "idMomento":idMomento,
      "nombreMomento":nombreMomento,
      "pathMomento":pathMomento,
      "colorMomento":colorMomento,
      "isPredeterminado":isPredeterminado,
    };
  }



 }