import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/ui/address_api/place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion>{
  String sessionToken;
  PlaceApiProvider apiClient;
  AddressSearch({required this.sessionToken, required this.apiClient});


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        /*close(context, null);*/
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestion>>(
      future: query == ""
          ? null
          : PlaceApiProvider(sessionToken).fetchSuggestions(
          query),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Enter your address'),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title:
          Text((snapshot.data![index]).description),
          onTap: () {
            close(context, snapshot.data![index]);
          },
        ),
        itemCount: snapshot.data!.length,
      )
          : Container(child: Text('Loading...')),
    );
  }

}