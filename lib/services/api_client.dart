import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';

import 'app_exception.dart';

class ApiClient{
  final String _baseUrl = 'http://kidzoo-dev.us-east-1.elasticbeanstalk.com';

  Future<dynamic> getData(String url) async {
    var responseJson;
    try {
      // final response = await get(Uri.https('$_baseUrl','$url'));
      print('URL is ${_baseUrl+url}');
      final Response response = await get(Uri.parse('${_baseUrl+url}'),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      print('response.statusCode ${response.statusCode}');
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getDataByPostCall(String url,String uid) async {
    var responseJson;
    try {
      // final response = await get(Uri.https('$_baseUrl','$url'));
      print('URL is ${_baseUrl+url}');
      final Response response = await post(Uri.parse('${_baseUrl+url}'),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },body: jsonEncode('$uid'));
      print('response.statusCode ${response.statusCode}');
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  uploadPic(File _image,String url) async {
    var uri = Uri.parse('${_baseUrl+url}');
    var request = MultipartRequest('POST', uri)
      /*..fields['FormFile']='$imgUrl'*/
      ..files.add(MultipartFile.fromBytes('FileForm', /*await File.fromUri("<path/to/file>").readAsBytes()*/_image.readAsBytesSync()));
    StreamedResponse response = await request.send();
    print('Image upload response code is ${response.statusCode}' );
    print('Image upload response is ${response.toString()}');
    if (response.statusCode == 200) print('Uploaded!');
  }

  /*void uploadFile(File file, String tag, callback) {
    final xhr = HttpRequest();
    xhr.open('POST', "upload/", true);
    xhr.on.readyStateChange.add((e) {
      if (xhr.readyState == 4 && xhr.status == 200) {
        callback();
      }
    });
    final formData = new FormData();
    formData.appendBlob('file', file);
    formData.append('tag', tag);
    xhr.send(formData);
  }*/

  Future<dynamic>  addData(dynamic requestBody,String url) async {
    var responseJson;
    try {
      print('URL is ${_baseUrl+url}');
    final Response response = await post(Uri.parse('${_baseUrl + url}'),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(requestBody));


    /*print('req body  ${jsonEncode(requestBody)}');*/
    log('req body  ${jsonEncode(requestBody)}');

    print('response.statusCode ${response.statusCode}');
    print('response body ${response.body.toString()}');

    /*if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print('response.body  ${response.body}');
      return response.body;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create parent.');
    }*/
    responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> addDataByQueryParam(String url) async {
    var responseJson;
    try {
      // final response = await get(Uri.https('$_baseUrl','$url'));
      print('URL is ${_baseUrl+url}');
      final Response response = await post(Uri.parse('${_baseUrl+url}'),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
      print('response.statusCode ${response.statusCode}');
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson;
        try {
          responseJson = json.decode(response.body.toString());
          print('responseJson $responseJson');
        }catch(e){
          print(e);
          responseJson = response.body.toString();
        }
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response
                .statusCode}');
    }
  }



}