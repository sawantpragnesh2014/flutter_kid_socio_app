import 'dart:convert';
import 'dart:io';

import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/services/api_client.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';

class ParentRepository {
  final ApiClient apiClient = ApiClient();
  List<Parent>? results;

  Future<Parent?> fetchParent({required String uid}) async {
    final response = await apiClient.getDataByPostCall('/api/UserMaster/GetById',uid);
    // final response = await apiClient.getData('/api/UserMaster/GetById');
    return ParentResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ParentResponse
        .fromJson(response)
        .results[0];
  }

  Future<int> createParent(Parent parent) async {
    print('Parent is $parent');
    /*Map<String, dynamic> parentMap = convertToDto(parent);*/
    final dynamic response = await apiClient.addData(parent, '/api/UserMaster/Create');

    /*return ParentResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ParentResponse
        .fromJson(response)
        .results[0];*/
    print('create parent response ${response}');
    print('create parent response ${response['data']}');
    print('create parent response ${response['userId']}');
    var data = response['data'];
    return data;
  }

  Future<String?> updateParent(Parent parent) async {
    print('Parent is $parent');
    return apiClient.addData(parent, '/api/UserMaster/Update') as String?;
  }

  Future<void> uploadParentPic(int id, /*Map<*/String/*, dynamic>*/ photoUrl) async {
    File file = await ImageUtils.getFileByUrl('parent_profile_pic', photoUrl) ?? File('');
     return apiClient.uploadPic(file, '/api/UserMaster/UploadParentImage?Id=$id');
  }

  Future<String?> fetchParentPic(int id) async {
    final dynamic response = await apiClient.getData('/api/UserMaster/GetParentImage?Id=$id');
    print('fetchParentPic response ${response['data']}');
    var data = response['data'];
    return data;
  }
}
