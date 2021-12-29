import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ImageUtils{

 static File imageFromBase64String(String base64String) {
   var file = File("assets/vector_png.png");
   file.writeAsBytesSync(base64Decode(base64String));
    // return File.fromRawPath(base64Decode(base64String));
    return file;
  }

  static String? upload(File? _image) {
    if (_image == null) return null;
    String base64Image = base64Encode(_image.readAsBytesSync());
/*    String fileName = _image.path.split("/").last;*/
    return base64Image;
  }

 static Future<File?> writeFile(String fileName, String imageAnalysed) async {
   final decodedBytes = base64Decode(imageAnalysed );
   final directory = await getApplicationDocumentsDirectory();
   File? fileImg = File('${directory.path}/$fileName.png');
   print(fileImg.path);
   fileImg.writeAsBytesSync(List.from(decodedBytes));
   print('fileImg $fileImg');
   return fileImg;
 }

 static Future<File?> getFile(String fileName/*, String? url*/) async {
   final directory = await getApplicationDocumentsDirectory();
   File? fileImg = File('${directory.path}/$fileName.png');
   bool val = await fileImg.exists();
   print('file exists $fileName $val');
   if(val){
     print('file val $fileImg');
     return fileImg;
   } /*else if(!val && url != null && url.length != 0 ){
     fileImg = await writeFile(fileName,url);
     print('file val $fileImg');
     return fileImg;
   }*/ else {
     return null;
   }
 }

 static Future<File?> getFileByUrl(String fileName, String? url) async {
   File? fileImg;
   if(url != null && url.length != 0 ){
     fileImg = await writeFile(fileName,url);
     print('file val $fileImg');
     return fileImg;
   } else {
     return null;
   }
 }

 static Future<File?> getTempFile(String fileName) async {
   final directory = await getTemporaryDirectory();
   File? fileImg = File('${directory.path}/$fileName.png');
   bool val = await fileImg.exists();
   print('file exists $fileName $val');
   if(val){
     print('file val $fileImg');
     return fileImg;
   } /*else if(!val && url != null && url.length != 0 ){
     fileImg = await writeFile(fileName,url);
     print('file val $fileImg');
     return fileImg;
   } */else {
     return null;
   }
 }

 static Future<File?> getTempFileByUrl(String fileName, String? url) async {
   File? fileImg;
   if(url != null && url.length != 0 ){
     fileImg = await writeFile(fileName,url);
     print('file val $fileImg');
     return fileImg;
   } else {
     return null;
   }
 }

}