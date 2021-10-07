
class EntityHistoria{
    int idHistoria;
    String nombreHistoria;
    String pathHistoria;

  EntityHistoria(this.nombreHistoria, this.pathHistoria);

    EntityHistoria.fromMap(Map<String, dynamic> map){
        idHistoria= map['idHistoria'];
        nombreHistoria=map['nombreHistoria'];
        pathHistoria = map['pathHistoria'];
     }

    Map<String, dynamic> toMap(){
      return{
        "idHistoria":idHistoria,
        "nombreHistoria":nombreHistoria,
        "pathHistoria":pathHistoria,
      };
    }



}