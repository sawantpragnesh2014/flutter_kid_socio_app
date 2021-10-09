import 'package:equatable/equatable.dart';

class ChildHobbies extends Equatable{
  final int id;
  final String name;
  bool isSelected;

  ChildHobbies({this.id,this.name,this.isSelected = false});

  static ChildHobbies fromJson(dynamic json){
    return ChildHobbies(
        id: json['hobbiesId'],
        name: json['hobbiesName']
    );
  }

  @override
  String toString() {
    return 'ChildHobbies{id: $id, name: $name, isSelected: $isSelected}';
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

class ChildHobbiesDto extends Equatable{
  final int childId;
  final List hobbies;
  final String hobbiesName;

  ChildHobbiesDto({this.childId,this.hobbies,this.hobbiesName});

  @override
  List get props => [childId,hobbies,hobbiesName];

  Map toJson() => {
    'childId': childId,
    'childHobby': hobbies,
    'hobbiesName': hobbiesName
  };

}