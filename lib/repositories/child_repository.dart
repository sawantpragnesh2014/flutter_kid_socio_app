
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/child_hobbies.dart';
import 'package:flutter_kid_socio_app/services/api_client.dart';

class ChildRepository{
  final ApiClient apiClient = ApiClient();
  List<Child> results;

  Future<Child> fetchChild({String childId}) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results[0];
  }

  Future<String> createChild(Child child) async {
    print('Child is $child');
    Map<String, dynamic> childMap = convertToDto(child);

    return apiClient.addData(childMap, '/api/UserMaster/Create');
  }

  Future<String> createChildHobbies(ChildHobbies childHobbies) async {
    print('Child hobbies are $childHobbies');
    Map<String, dynamic> childMap = convertToChildHobbiesDto(childHobbies);

    return apiClient.addData(childMap, '/api/ChildHobbies/Create');
  }

  Future<String> updateChild(Child child) async {
    print('Child is $child');
    Map<String, dynamic> childMap = convertToDto(child);

    return apiClient.addData(childMap, '/api/UserMaster/Update');
  }

  Future<String> updateChildHobbies(ChildHobbies childHobbies) async {
    print('Child is $childHobbies');
    Map<String, dynamic> childMap = convertToChildHobbiesDto(childHobbies);

    return apiClient.addData(childMap, '/api/ChildHobbies/Update');
  }

  Future<List<Child>> fetchChildRequestsList(String childId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results;
  }

  Future<List<Child>> fetchRecentPlaydatesList(String childId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results;
  }

  Future<List<Child>> fetchNearbyPlaydatesList(String childId) async {
    final response = await apiClient.getData('/api/ChildMaster/GetChild?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results;
  }

  Future<List<Child>> fetchFriendsList(String childId) async {
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
      'childId': child.id ?? 0,
      'parentId': child.parentId,
      'firstName': child.name,
      'lastName': child.name,
      'schoolName': child.schoolName,
      'dob': child.dob,
      'image': child.photoUrl,
      'gender': child.gender,
    };

    return childMap;
  }

  Map<String, dynamic> convertToChildHobbiesDto(ChildHobbies childHobbies) {
    Map<String, dynamic> childHobbiesMap = {
      'childId': childHobbies.childId,
      'childHobby': childHobbies.hobbies,
      'hobbiesName': childHobbies.hobbiesName
    };

    return childHobbiesMap;
  }
}