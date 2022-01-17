import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/add_child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/models/playdate_request.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';

import 'colors.dart';

class ChildInfoTwo extends StatefulWidget {
  final NearbyPlaydate? childAll;
  final PlayDateRequest? playDateRequest;

  ChildInfoTwo({this.childAll,this.playDateRequest});

  @override
  _ChildInfoTwoState createState() => _ChildInfoTwoState();
}

class _ChildInfoTwoState extends State<ChildInfoTwo> {
  late String address;
  late String firstName;
  late int id;
  late String type;
  String? photoUrl;
  File? image;

  @override
  void initState() {
    super.initState();
    address = CustomBlocProvider.getBloc<LoginBloc>()!.parent!.addressStr;
    // photoUrl = widget.childAll == null ? widget.playDateRequest!.photoUrl : widget.childAll!.photoUrl;
    setPhotoUrl();
    firstName = widget.childAll == null ? widget.playDateRequest!.firstName : widget.childAll!.firstName;
    id = widget.childAll == null ? widget.playDateRequest!.requestId : widget.childAll!.childId;
    type = widget.childAll == null ? 'playDateRequest' : 'nearbyPlaydate';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setFileImage(photoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: image == null
                    ? AssetImage('assets/default_profile_picture.png')
                    : FileImage(image!) as ImageProvider,
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.all( Radius.circular(60.0)),
              border: Border.all(
                color: AppColors.colorEB4C57,
                width: 8.0,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$firstName',style: AppStyles.blackTextMedium36,),
              Text(address,style: AppStyles.blackTextMedium14),
              Text('6th, August - 2 hours ago',style: AppStyles.editTextStyle,),
            ],
          )

        ],
      ),
    );
  }

  Future<void> setFileImage(String? url) async {
    if(image != null){
      return;
    }
    image = await ImageUtils.getFile('${type}_${id}_img');
    if(image == null){
      image = await ImageUtils.getFileByUrl('${type}_${id}_img',url);
    }
    if(image == null){
      return;
    }
    setState(() {
    });
  }

  Future<void> setPhotoUrl() async {
    photoUrl = widget.childAll == null ? await CustomBlocProvider.getBloc<ChildBloc>()!.fetchChildPic(widget.playDateRequest!.requestId) : await CustomBlocProvider.getBloc<ChildBloc>()!.fetchChildPic(widget.childAll!.childId);
  }
}
