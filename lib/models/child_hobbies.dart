import 'package:equatable/equatable.dart';

class ChildHobbies extends Equatable{
  final int childId;
  final List hobbies;
  final String hobbiesName;

  ChildHobbies({this.childId,this.hobbies,this.hobbiesName});

  @override
  List get props => [childId,hobbies,hobbiesName];

  static ChildHobbies fromJson(dynamic json){
    return ChildHobbies(
      childId: json['childId'],
      hobbies: json['childHobby'],
      hobbiesName: json['hobbiesName']
    );
  }

}

class ChildHobbiesResponse{
  List<ChildHobbies> results;

  ChildHobbiesResponse.fromJson(dynamic json){
    results = <ChildHobbies>[];
    var totalResults = json['data'];
    if(totalResults != null){
      totalResults.forEach((v) {
        results.add(ChildHobbies.fromJson(v));
      });
    }
  }
}