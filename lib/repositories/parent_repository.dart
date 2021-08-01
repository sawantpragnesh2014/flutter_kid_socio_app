import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/services/api_client.dart';

class ParentRepository{
  final ApiClient apiClient = ApiClient();
  List<Parent> results;

  Future<Parent> fetchParent({String uid}) async {
    final response = await apiClient.getData('/api/users/getById?UID=$uid');
    return ParentResponse.fromJson(response).results.isEmpty? null : ParentResponse.fromJson(response).results[0];
  }

  void createParent(Parent parent) async{
    print('Parent is $parent');
    Map<String,dynamic> parentMap = {
      'userId': 0,
      'uid': parent.uid,
      'firstName':parent.firstName,
      'lastName':parent.lastName,
      'mobileNo':parent.phoneNo,
      'emailId':parent.email,
      'gender':parent.gender,
      "isOtpVerified": true,
      "userStatus": true,
      "isUserBan": false,
      "userType": 3,
      "updatedBy": 0
    };
    apiClient.addData(parentMap,'/api/users/create');
  }

}