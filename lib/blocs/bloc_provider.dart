import 'package:flutter/material.dart';

import 'bloc.dart';

/*class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  // 2
  static T of<T extends Bloc>(BuildContext context) {
    final type = _providerType<BlocProvider<T>>();
    final BlocProvider<T> provider = findAncestorWidgetOfExactType(type);
    return provider.bloc;
  }

  // 3
  static Type _providerType<T>() => T;

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  // 4
  @override
  Widget build(BuildContext context) => widget.child;

  // 5
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}*/

class CustomBlocProvider {
  static Map<Type, Bloc> _singletonBlocMap = {};
  static Map<Type, Map<String, Bloc>> _blocMap = {};

  static setBloc<T extends Bloc>(T bloc, {String? identifier}) {
    if (identifier == null) {
      _singletonBlocMap[T] = bloc;
    } else {
      Map<String, Bloc>? blocIdentifierMap = _blocMap[T];
      if (blocIdentifierMap == null) {
        blocIdentifierMap = {};
        _blocMap[T] = blocIdentifierMap;
      }
      blocIdentifierMap[identifier] = bloc;
    }
  }

  static T? getBloc<T extends Bloc>({String? identifier}) {
    if (identifier == null) {
      return _singletonBlocMap[T] as T;
    } else {
      Map<String, Bloc>? blocIdentifierMap = _blocMap[T];
      if (blocIdentifierMap != null) {
        return blocIdentifierMap[identifier] as T;
      }
    }
    return null;
  }

  static disposeAllBlocs() {
    _singletonBlocMap = {};
    _blocMap = {};
  }
}