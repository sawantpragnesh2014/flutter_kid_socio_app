import 'package:equatable/equatable.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';

class BaseChild extends Equatable{
  final String firstName;
  final String lastName;
  final String? photoUrl;

  BaseChild({required this.firstName,required this.lastName,required this.photoUrl});


  @override
  List get props => [firstName,lastName,photoUrl];

  static BaseChild fromJson(dynamic json){
    return BaseChild(
        firstName: json['firstname'],
        lastName: json['lastname'],
        photoUrl: json['image'] ?? '',
    );
  }

  Map toJson() => {
    'firstname': firstName,
    'lastname': lastName,
    'image': photoUrl,
    'schoolAddress':'string'
  };

}