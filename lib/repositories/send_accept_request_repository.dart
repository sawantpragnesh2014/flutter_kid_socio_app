import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/playdate_request.dart';
import 'package:flutter_kid_socio_app/models/send_request.dart';
import 'package:flutter_kid_socio_app/services/api_client.dart';

class SendAcceptRequestRepository{
  final ApiClient apiClient = ApiClient();

  Future<String> sendRequest(SendRequest sendRequest) async {
    final dynamic response = await apiClient.addData(sendRequest, '/api/Requests/SendRequest');
    print('sendRequest response ${response['responseMessage'].toString()}');
    return response['responseMessage'].toString();
  }

  Future<String> approveRequest(int requestId,int statusId) async {
    final dynamic response = await apiClient.addDataByQueryParam('/api/Requests/ApproveRequest?RequestId=$requestId&StatusId=$statusId');
    return response['responseMessage'].toString();
  }

  Future<List<PlayDateRequest>?> getIncomingRequestList(int childId) async {
    final response = await apiClient.getData('/api/Requests/IncomingRequests?ChildId=$childId');
    return PlayDateRequestResponse
        .fromJson(response)
        .results
        .isEmpty ? null : PlayDateRequestResponse
        .fromJson(response)
        .results;
  }

  Future<List<PlayDateRequest>?> getOutgoingRequestList(int childId) async {
    final response = await apiClient.getData('/api/Requests/OutGoingRequests?ChildId=$childId');
    return PlayDateRequestResponse
        .fromJson(response)
        .results
        .isEmpty ? null : PlayDateRequestResponse
        .fromJson(response)
        .results;
  }

  Future<List<Child>?> getUpcomingPlaydateList(int childId) async {
    final response = await apiClient.getData('/api/Requests/UpcomingRequests?ChildId=$childId');
    return ChildResponse
        .fromJson(response)
        .results
        .isEmpty ? null : ChildResponse
        .fromJson(response)
        .results;
  }
}
