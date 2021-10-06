import 'dart:convert';

import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/services/api_client.dart';

class ParentRepository {
  final ApiClient apiClient = ApiClient();
  List<Parent> results;

  Future<Parent> fetchParent({String uid}) async {
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
    Map<String, dynamic> parentMap = convertToDto(parent);
    print('Parent dto is $parentMap');
    final dynamic response = await apiClient.addData(parentMap, '/api/UserMaster/Create');

    /*return ParentResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ParentResponse
        .fromJson(response)
        .results[0];*/

    return response['userId'];
  }

  Future<String> updateParent(Parent parent) async {
    print('Parent is $parent');
    Map<String, dynamic> parentMap = convertToDto(parent);

    return apiClient.addData(parentMap, '/api/UserMaster/Update');
  }

  Map<String, dynamic> convertToDto(Parent parent) {
    Map<String, dynamic> parentMap = {
      'userId': parent.id ?? 0,
      'uid': parent.uid,
      'emailId': parent.email,
      'firstName': parent.firstName,
      'lastName': parent.lastName,
      'gender': parent.gender,
      'mobileNo': parent.phoneNo,
      'isOtpVerified': true,
      'userStatus': true,
      'isUserBan': false,
      'userType': 3,
      'updatedBy': 0,
      'parentImage': parent.photoUrl,
      'userPersonal': convertToAddressDto(parent.address),
      'userCreatedDate': '2021-10-04T07:24:39.325Z',
      'userModifiedDate': '2021-10-04T07:24:39.325Z',
    };
    return parentMap;
  }

  Map<String,dynamic> convertToAddressDto(Address address){
    Map<String,dynamic> addressMap = {
      'userId': address.id ?? 0,
      'address': address.address,
      'zipCode': address.pinCode,
      'state': 'string',
      'city': 'string',
      'landmark': 'string',
      'createdDate': '2021-10-04T07:24:39.325Z',
      'updatedDate': '2021-10-04T07:24:39.325Z'
    };
    return addressMap;
  }
}
