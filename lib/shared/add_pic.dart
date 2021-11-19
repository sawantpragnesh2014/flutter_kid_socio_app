import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:image_picker/image_picker.dart';

import 'action_button.dart';
import 'colors.dart';

typedef StringValue = void Function(String);

class AddPic extends StatefulWidget {
  final ButtonStyle btnStyle;
  final StringValue onActionBtnHit;
  final String photoUrl;

  @override
  _AddPicState createState() => _AddPicState();

  AddPic({required this.btnStyle,required this.onActionBtnHit,this.photoUrl = ''});
}

class _AddPicState extends State<AddPic> {
  final _picker = ImagePicker();
  File? _image;
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
                    image: (_image != null ? FileImage(_image!) : widget.photoUrl.isNotEmpty ? NetworkImage(widget.photoUrl + '?width=400&height400'):AssetImage('assets/facebook_logo.png')) as ImageProvider,
                    fit: BoxFit.cover,
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
              String? s = _upload();
              /*_image =*/
              widget.onActionBtnHit(_upload()??'');
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
    final pickedFile = await _picker.getImage(source: ImageSource.camera,);
    final File image = File(pickedFile!.path);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery,);
    final File image = File(pickedFile!.path);
    setState(() {
      _image = image;
    });
  }

  String? _upload() {
    if (_image == null) return null;
    String base64Image = base64Encode(_image!.readAsBytesSync());
/*    String fileName = _image.path.split("/").last;*/
    return base64Image;
  }

  /*void writeFile(String imageAnalysed) async {
    final decodedBytes = base64Decode(imageAnalysed);
    final directory = await getApplicationDocumentsDirectory();
    fileImg = File('${directory.path}/testImage.png');
    print(fileImg.path);
    fileImg.writeAsBytesSync(List.from(decodedBytes));

    setState(() {
      isLoading = false;
    });
  }*/
}
