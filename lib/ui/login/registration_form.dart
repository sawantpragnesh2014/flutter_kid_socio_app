import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/repositories/location_repository.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/gender_view.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/address_api/AddressSearch.dart';
import 'package:flutter_kid_socio_app/ui/address_api/place_service.dart';
import 'package:flutter_kid_socio_app/ui/login/add_profile_pic.dart';
import 'package:flutter_kid_socio_app/ui/login/phone_verification.dart';
import 'package:flutter_kid_socio_app/ui/login/privacy_policy.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  // print(list['age']); //32


  bool _agree = true;
  User? user;

  late LoginBloc _loginBloc;
  late AuthBloc _authBloc;
  String?  _sessionToken;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

    Widget get _lastName {
    return TextFormField(
      initialValue: user?.displayName?.split(' ')[1] ?? '',
      textCapitalization: TextCapitalization.words,
      decoration: AppStyles.textInputDecoration.copyWith(hintText: 'Last Name'),
      validator: (val) => FormValidators.validateName(val!),
      onChanged: (val){
        setState(() {
          _loginBloc.lastName = val;
        });
      },
    );
  }

  Widget get _firstName {
    return TextFormField(
      initialValue: user?.displayName?.split(' ')[0] ?? '',
      textCapitalization: TextCapitalization.words,
      decoration: AppStyles.textInputDecoration.copyWith(hintText: 'First Name'),
      validator: (val) => FormValidators.validateName(val!),
      onChanged: (val){
        setState(() {
          _loginBloc.firstName = val;
        });
      },
    );
  }

  Widget get _email {
    return TextFormField(
      initialValue: user?.email,
      decoration: AppStyles.textInputDecoration.copyWith(hintText: 'Email'),
      validator: (val) => FormValidators.validateEmail(val),
      onChanged: (val){
        setState(() {
          _loginBloc.email = val;
        });
      },
    );
  }

  Widget get _pinCode {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: AppStyles.textInputDecoration.copyWith(hintText: 'Pincode'),
      validator: (val) => FormValidators.validatePinCode(val!),
      onChanged: (val){
        setState(() {
          _loginBloc.pinCode = val;
        });
      },
    );
  }

  Widget get _address {
    return TextFormField(
      controller: _controller,
      onTap: () async{
        // generate a new token here
        if(_sessionToken == null) {
          _sessionToken = Uuid().v4();
        }
        final Suggestion? result = await showSearch(
          context: context,
          delegate: AddressSearch(sessionToken: _sessionToken!,apiClient: PlaceApiProvider(_sessionToken!)),
        );
        // This will change the text displayed in the TextField
        if (result != null) {
          setState(() {
            _controller.text = result.description;
          });
        }
      },
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      decoration: AppStyles.textInputDecoration.copyWith(hintText: 'Address'),
      validator: (val) => FormValidators.validateName(val!),
      onChanged: (val){
        setState(() {
          _loginBloc.addressName = val;
        });
      },
    );
  }


  Widget get _buildAgreeToTermsField {
    return FormField<bool>(
      initialValue: _agree,
      builder: (FormFieldState<bool> state) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: state.value,
                  onChanged: (bool? val) => setState(() {
                    _agree = val!;
                    state.didChange(val);
                  }),
                  activeColor: AppColors.color7059E1,
                  checkColor: Colors.white,
                ),
                RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'By continuing you agree to the ',style: AppStyles.blackTextMedium14),
                          TextSpan(
                              text: '\nT & C',
                              style: AppStyles.hyperlinkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms of Service');
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Policy()));
                                }),
                          TextSpan(text: ' and ',style: AppStyles.blackTextMedium14),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: AppStyles.redTextSmall,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Privacy Policy');
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Policy()));
                                }),
                        ]
                    )
                )
              ],
            ),
            Text(state.errorText ?? '', style: TextStyle(color: Colors.red)),
          ],
        );
      },
      // 7
      validator: (val) => _validateTerms(_agree),
    );
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = CustomBlocProvider.getBloc<LoginBloc>()!;
    _authBloc = CustomBlocProvider.getBloc<AuthBloc>()!;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    user = _authBloc.getUser;
    _loginBloc.firstName =  user?.displayName?.split(' ')[0] ?? '';
    _loginBloc.lastName =  user?.displayName?.split(' ')[1] ?? '';
    _loginBloc.email =  user?.email ?? '';
    _loginBloc.gender = 'Male';
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarNew(height: 120.0,),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Form(
          key: formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Registration',
                              style: TextStyles.redText
                          ),
                          SizedBox(height: 20.0,),
                          Text(
                              'Parent Info',
                              style: TextStyles.hyperlinkStyle
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                              'Enter your details below',
                              style: TextStyles.kSubTitleStyle
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap:(){
                        },
                        child: CircleAvatar(
                          *//*backgroundImage: NetworkImage(user?.photoUrl + '?width=400&height400'),*//*
                          radius: 40.0,
                        ),
                      )
                    ],
                  ),*/
                  Text(
                      "Parent's Registration",
                      style: AppStyles.blackTextBold16
                  ),
                  SizedBox(height: 20.0,),
                  _firstName,
                  SizedBox(height: 20.0,),
                  _lastName,
                  SizedBox(height: 20.0,),
                  _email,
                  SizedBox(height: 20.0,),
                  _address,
                  SizedBox(height: 20.0,),
                  _pinCode,
                  SizedBox(height: 20.0,),
                  GenderView(callback: (value){
                      print('gender is $value');
                      return _loginBloc.gender = value;
                  },),
                  SizedBox(height: 20.0,),
                  _buildAgreeToTermsField,
                  ActionButtonView(
                      btnName: "Continue",
                      onBtnHit: () async {
                        if(formKey.currentState!.validate()) {
                          UserLocationData? _userLocationData = await LocationRepository().getLocation();

                          var status = await Permission.location.status;

                          print('status.isDenied ${status.isDenied}');
                          print('status.isDenied ${status.isPermanentlyDenied}');


                          if(status.isGranted){
                            print('lat ${_userLocationData!.locationData!.latitude}');
                            print('lon ${_userLocationData.locationData!.longitude}');
                            _loginBloc.lat = _userLocationData.locationData!.latitude!;
                            _loginBloc.lon = _userLocationData.locationData!.longitude!;
                            print('phone num ${user!.phoneNumber}');
                            if(user!.phoneNumber == null || user!.phoneNumber!.isEmpty) {
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => PhoneVerification()));
                          } else{
                            _loginBloc.phoneNo = user!.phoneNumber!.replaceAll('+91', '');
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => AddProfilePic()));
                            }
                          }else if (status.isDenied){
                            /*ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please provide location access to continue.'),
                              ),
                            );*/
                            openAppSettings();
                          }else {
                            openAppSettings();
                          }
                          /*if(_userLocationData == null || _userLocationData.permissionStatus == PermissionStatus.denied || _userLocationData.permissionStatus == PermissionStatus.deniedForever){
                            openAppSettings();
                            *//*ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please provide location access to continue.'),
                              ),
                            );*//*
                            return;
                          }*/
                        }
                      }
                  ),
                  SizedBox(height: 20.0,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateTerms(bool agree) {
    return agree ? null:"You must agree before proceeding";
  }


}
