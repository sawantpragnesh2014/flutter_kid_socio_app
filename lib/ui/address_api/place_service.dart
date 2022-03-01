import 'dart:convert';

import 'package:http/http.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;
  final apiKey = 'AIzaSyDO0p69-L90955UteFioWWY13Xzx0ELiOA';

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    print("fetchSuggestions called");
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&components=country:ch&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));
    print("fetchSuggestions response  ${response.body}");
    print("fetchSuggestions response status ${response.statusCode}");
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  /*Future<Place> getPlaceDetailFromId(String placeId) async {
    // if you want to get the details of the selected place by place_id
  }*/
}