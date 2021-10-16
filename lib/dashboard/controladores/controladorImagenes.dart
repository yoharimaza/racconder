import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:racconder/config/racconder_theme.dart';

class ControladorImagenes{

  obtenerRuta(String extension) async{
    var path;
    if (Platform.isIOS) {
      path = p.join(
        (await getApplicationDocumentsDirectory()).path,
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().millisecond}$extension',
      );
    } else {
      path = p.join(
        (await getExternalStorageDirectory()).path,
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().millisecond}$extension',
      );
    }
    return path;
  }

  Future<File> desdeGaleria() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: TemaRacconder.primaryColor,
            toolbarTitle: "Recortar Imagen",
            statusBarColor: TemaRacconder.primaryColor,
            backgroundColor: Colors.black,
          )
      );

      if(cropped != null){
        String ruta = await obtenerRuta(p.extension(File(cropped.path).path));
        File newImage = await File(cropped.path).copy(ruta);
        return newImage;
      }
    }
  }

  Future<File> desdeCamara() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(
              ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: TemaRacconder.primaryColor,
            toolbarTitle: "Recortar Imagen",
            statusBarColor: TemaRacconder.primaryColor,
            backgroundColor: Colors.black,
          )
      );

      if(cropped != null){
        String ruta = await obtenerRuta(p.extension(File(cropped.path).path));
        File newImage = await File(cropped.path).copy(ruta);
        return newImage;
      }
    }
  }
}