
class EntidadProducto{
  int idProducto;
  String nombreProducto;
  String marcaProducto;
  String presentacionProducto;
  String descripcionProducto;
  int cantidadProducto;
  int duracionProducto;
  String rutaImagen;

  EntidadProducto(this.nombreProducto, this.marcaProducto, this.presentacionProducto, this.descripcionProducto, this.cantidadProducto, this.duracionProducto, this.rutaImagen);

  EntidadProducto.fromMap(Map<String, dynamic> map){
    idProducto= map['idProducto'];
    nombreProducto=map['nombreProducto'];
    marcaProducto = map['marcaProducto'];
    presentacionProducto = map['presentacionProducto'];
    descripcionProducto = map['descripcionProducto'];
    cantidadProducto = map['cantidadProducto'];
    duracionProducto = map['duracionProducto'];
    rutaImagen = map['rutaImagen'];
  }

  Map<String, dynamic> toMap(){
    return{
      "idProducto":idProducto,
      "nombreProducto":nombreProducto,
      "marcaProducto":marcaProducto,
      "presentacionProducto":presentacionProducto,
      "descripcionProducto":descripcionProducto,
      "cantidadProducto":cantidadProducto,
      "duracionProducto":duracionProducto,
      "rutaImagen":rutaImagen,
    };
  }



}