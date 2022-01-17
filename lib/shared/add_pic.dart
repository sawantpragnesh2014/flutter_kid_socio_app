import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';
import 'package:image_picker/image_picker.dart';

import 'action_button.dart';
import 'colors.dart';

typedef StringValue = void Function(String);

class AddPic extends StatefulWidget {
  final ButtonStyle btnStyle;
  final StringValue onActionBtnHit;
  final String photoUrl;
  File? image;

  @override
  _AddPicState createState() => _AddPicState();

  AddPic({required this.btnStyle,required this.onActionBtnHit,this.photoUrl = '',this.image});
}

class _AddPicState extends State<AddPic> {
  final _picker = ImagePicker();

  File? fileImg;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
                'Add your profile picture',
                style: AppStyles.blackTextBold16
            ),
            SizedBox(height: 20.0,),
            GestureDetector(
              onTap: (){
                _showPicker(context);
              },
              child: /*CircleAvatar(
                backgroundImage: AssetImage('assets/vector_png.png'),
                radius: 110.0,
                child: CircleAvatar(
                  backgroundImage: _image != null ? FileImage(_image) : widget.photoUrl != null ? NetworkImage(widget.photoUrl + '?width=400&height400'):AssetImage('assets/facebook_logo.png'),
                  radius: 80.0,
                ),
              ),*/
              Container(
                height: 300.0,
                width: 300.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: (widget.image != null ? FileImage(widget.image!) : widget.photoUrl.isNotEmpty ? NetworkImage(widget.photoUrl + '?width=400&height400'):AssetImage('assets/default_profile_picture.png')) as ImageProvider,
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.all( Radius.circular(180.0)),
                  border: Border.all(
                    color: AppColors.colorEB4C57,
                    width: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 80.0,),
            ActionButtonView(btnName: "Continue",onBtnHit: (){
              print('Action btn hit');
              String? base64StringFromImage = ImageUtils.upload(widget.image);
              /*_image =*/
              widget.onActionBtnHit(base64StringFromImage??'');
            },buttonStyle: widget.btnStyle,),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  _imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera,imageQuality: 85,);
    final File image = File(pickedFile!.path);

    setState(() {
      widget.image = image;
    });
  }

  _imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 85,);
    final File image = File(pickedFile!.path);
    setState(() {
      widget.image = image;
    });
  }
}
