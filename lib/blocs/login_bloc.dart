/*
import 'dart:async';

import 'package:flutter_kid_socio_app/blocs/bloc.dart';
import 'package:flutter_kid_socio_app/models/user.dart';

class LoginBloc extends Bloc {
  // UserRepository _userRepository;
  User user;

StreamController userController;

Stream get userStream => userController.stream;
LoginBloc(){
  userController = StreamController<User>.broadcast();
  // _userRepository = UserRepository.getInstance();
}

getUser() async{
  userController.sink.add(handleSignIn().then((user) => {
    this.user = user,
  }));
}

  @override
  void dispose() {
    userController.close();
  }

}
*/
