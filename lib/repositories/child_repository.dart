import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/child_hobbies.dart';
import 'package:flutter_kid_socio_app/models/child_timings.dart';
import 'package:flutter_kid_socio_app/services/api_client.dart';

class ChildRepository{
  final ApiClient apiClient = ApiClient();
  List<Child>? results;

  Future<Child?> fetchChild({required String childId}) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results[0];
  }

  Future<List<Child>?> fetchAllChildByParentId(String parentId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetAllChildParent?UserId=$parentId');
    try {
      return ChildResponse
          .fromJson(response)
          .results
          .isEmpty ? null : ChildResponse
          .fromJson(response)
          .results;
    } catch(e){
      print('Error parsing child list $e');
      return [];
    }
  }

  Future<List<ChildHobbies>?> fetchHobbiesMaster() async {
    final response = await apiClient.getData('/api/hobbieslist');
    return ChildHobbiesResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildHobbiesResponse
        .fromJson(response)
        .results;
  }

  Future<Child?> createChild(Child child) async {
    print('Child is $child');

    final dynamic response = await apiClient.addData(child, '/api/Child/Create');

    return ChildResponse.fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results[0];
  }

  Future<void> createChildHobbies(ChildHobbiesDto childHobbiesDto) async {
    print('Child hobbies are $childHobbiesDto');
    /*Map<String, dynamic> childMap = convertToChildHobbiesDto(childHobbies);*/
    apiClient.addData(childHobbiesDto, '/api/ChildHobbies/Create');
  }

  Future<void> createChildTimings(List<ChildTimings> childTimingsList) async {
    print('childTimingsList are $childTimingsList');
    /*Map<String, dynamic> childMap = ChildTimings.toJson(childTimingsList[0]);*/
    apiClient.addData(ChildTimingsList(childTimingsList), '/api/ChildTimings/Create');
  }

  Future<String?> updateChild(Child child) async {
    print('Child is $child');
    /*Map<String, dynamic> childMap = convertToDto(child);*/

    return apiClient.addData(child, '/api/UserMaster/Update') as String?;
  }

  Future<String?> updateChildHobbies(ChildHobbies childHobbies) async {
    print('Child is $childHobbies');
    /*Map<String, dynamic> childMap = convertToChildHobbiesDto(childHobbies);*/

    return apiClient.addData(childHobbies, '/api/ChildHobbies/Update') as String?;
  }

  Future<List<Child>?> fetchChildRequestsList(String childId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results;
  }

  Future<List<Child>?> fetchRecentPlaydatesList(String childId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results;
  }

  Future<List<NearbyPlaydate>?> fetchNearbyPlaydatesList(String parentId,String childId) async {
    final response = await apiClient.getData('/api/Requests/GetChildLists?ChildId=$childId&ParentId=$parentId');
    return NearbyPlaydateResponse
        .fromJson(response)
        .results
        .isEmpty ? null : NearbyPlaydateResponse
        .fromJson(response)
        .results;
  }

  Future<List<Child>?> fetchFriendsList(String childId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results;
  }

  Future<String> fetchChildPlaydatesCount(String childId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return response;
  }

  Future<String> fetchChildStarsCount(String childId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return response;
  }


  Map<String, dynamic> convertToDto(Child child) {
    Map<String, dynamic> childMap = {
      'childId': child.id,
      'parentId': child.parentId,
      'firstName': child.firstName,
      'lastName': child.lastName,
      'image': child.photoUrl,
      'schoolName': child.schoolName,
      'dob': child.dob,
      'gender': child.gender,
    };

    return childMap;
  }

  Future<void> uploadChildPic(int id, String photoUrl) {
    return apiClient.addData(photoUrl, '/api/UserMaster/UploadParentImage?Id=$id');
  }

  Future<String?> fetchChildPic(int id) async {
    final dynamic response = await apiClient.getData('/api/ChildMaster/GetChildImage?Id=$id');
    print('fetchChildPic response ${response['data']}');
    var data = response['data'];
    return data;
  }
}