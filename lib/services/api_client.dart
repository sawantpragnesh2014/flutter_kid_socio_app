import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';

import 'app_exception.dart';

class ApiClient{
  final String _baseUrl = 'https://kidzooapi.azurewebsites.net';

  Future<dynamic> getData(String url) async {
    var responseJson;
    try {
      // final response = await get(Uri.https('$_baseUrl','$url'));
      print('URL is ${_baseUrl+url}');
      final Response response = await post(Uri.parse('${_baseUrl+url}'),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<String>  addData(Map<String,dynamic> requestBody,String url) async {
    var responseJson;
    try {
    final Response response = await post(Uri.parse('${_baseUrl + url}'),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(requestBody));

    print('response.statusCode ${response.statusCode}');

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