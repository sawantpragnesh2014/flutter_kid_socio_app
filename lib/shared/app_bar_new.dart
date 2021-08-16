import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarNew extends StatelessWidget implements PreferredSizeWidget {

  final double height;

  AppBarNew({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
          Positioned(top: 49,
              left: 293,
              child: SvgPicture.asset('assets/vector.svg',
                  semanticsLabel: 'vector')),
          Positioned(top: 96,
              left: 156,
              child: SvgPicture.asset('assets/vector.svg',
                  semanticsLabel: 'vector')),
          Positioned(top: 59,
              left: 178,
              child: SvgPicture.asset('assets/vector.svg',
                  semanticsLabel: 'vector')),
          Positioned(top: 88,
              left: 267,
              child: SvgPicture.asset('assets/vector.svg',
                  semanticsLabel: 'vector')),
          Positioned(top: 89,
              left: 203,
              child: SvgPicture.asset('assets/vector.svg',
                  semanticsLabel: 'vector')),
          Positioned(top: 51,
              left: 235,
              child: SvgPicture.asset('assets/vector.svg',
                  semanticsLabel: 'vector')),
          Positioned(top: 62,
              left: 30,
              child: Container(width: 112.0002670288086,
                  height: 67.78770446777344,
                  child: Stack(children: <Widget>[
                    Positioned(top: 7.0489606857299805,
                        left: -7.275957614183426e-12,
                        child: SvgPicture.asset('assets/vector.svg',
                            semanticsLabel: 'vector')),
                    Positioned(top: 0,
                        left: 24.78239631652832,
                        child: SvgPicture.asset('assets/vector.svg',
                            semanticsLabel: 'vector')),
                    Positioned(top: 10.621886253356934,
                        left: 24.78239631652832,
                        child: SvgPicture.asset('assets/vector.svg',
                            semanticsLabel: 'vector')),
                    Positioned(top: 7.1458516120910645,
                        left: 35.42955780029297,
                        child: SvgPicture.asset('assets/vector.svg',
                            semanticsLabel: 'vector')),
                    Positioned(top: 38.81833267211914,
                        left: -7.275957614183426e-12,
                        child: SvgPicture.asset('assets/vector.svg',
                            semanticsLabel: 'vector')),
                    Positioned(top: 42.29496765136719,
                        left: 21.200443267822266,
                        child: SvgPicture.asset('assets/vector.svg',
                            semanticsLabel: 'vector')),
                    Positioned(top: 42.19807815551758,
                        left: 49.17482376098633,
                        child: SvgPicture.asset('assets/vector.svg',
                            semanticsLabel: 'vector')),
                    Positioned(top: 31.769371032714844,
                        left: 75.7000503540039,
                        child: Container(width: 7.938601493835449,
                            height: 36.01788330078125,
                            child: Stack(children: <Widget>[
                              Positioned(top: 0,
                                  left: 0,
                                  child: SvgPicture.asset('assets/vector.svg',
                                      semanticsLabel: 'vector')),
                              Positioned(top: 10.621726036071777,
                                  left: 0.0008313641883432865,
                                  child: SvgPicture.asset('assets/vector.svg',
                                      semanticsLabel: 'vector')),

                            ]))),
                    Positioned(top: 42.29496765136719,
                        left: 86.25092315673828,
                        child: Container(width: 25.74934196472168,
                            height: 25.492733001708984,
                            child: Stack(children: <Widget>[
                              Positioned(top: 0,
                                  left: 0,
                                  child: SvgPicture.asset('assets/vector.svg',
                                      semanticsLabel: 'vector')),

                            ]))),

                  ]))),
        ]));
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
