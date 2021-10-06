import 'dart:convert';
import 'dart:io';

class ImageUtils{

 static File imageFromBase64String(String base64String) {
   var file = File("assets/vector_png.png");
   file.writeAsBytesSync(base64Decode(base64String));
    // return File.fromRawPath(base64Decode(base64String));
    return file;
  }

}