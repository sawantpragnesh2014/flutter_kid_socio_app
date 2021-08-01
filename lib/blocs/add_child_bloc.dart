import 'dart:async';

import 'bloc.dart';

class AddChildBloc extends Bloc{
 StreamController childViewController = StreamController<Type>.broadcast();

  Stream get childListStream => childViewController.stream;
  StreamSink get childListSink => childViewController.sink;

  @override
  void dispose() {
    childViewController.close();
  }
}

enum Type{
  FORM,
  INTEREST,
  PROFILE
}