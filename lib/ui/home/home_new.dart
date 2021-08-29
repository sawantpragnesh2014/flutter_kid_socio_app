import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/add_child.dart';

class HomeNew extends StatefulWidget {
  @override
  _HomeNewState createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  Parent user;

   Widget get _addChildView {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AddChild()));
            },
            child: Card(
              color: AppColors.color7059E1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0,48.0,0.0,48.0,),
                child: Center(
                  child: Icon(
                    Icons.add_circle_outline_rounded,
                    color: Colors.white,
                    size: 48.0,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text('Add Child',style: TextStyles.blackTextRegular,textAlign: TextAlign.center,),
        )
      ],
    );
  }

  Widget _childListView(List<Child> childList) {
    return Container(
      height: 180.0,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 8.0);
          },
          scrollDirection: Axis.horizontal,
          itemCount: childList.length,
          itemBuilder: (context,index){
            return childListView(childList[index]);
          }),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = CustomBlocProvider.getBloc<AuthBloc>().getUser;
  }

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(ChildBloc());
  }

  @override
  void dispose() {
    super.dispose();
    CustomBlocProvider.getBloc<ChildBloc>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Child>>(
        stream: CustomBlocProvider.getBloc<ChildBloc>().childListStream,
        builder: (context, snapshot) {
          List<Child> childList = snapshot.data ?? [];
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBarView(height: 150.0,),
              body: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        childList.isEmpty?_addChildView:_childListView(childList),
                        SizedBox(height: 16.0,),
                        Text('Lets get you started',textAlign: TextAlign.center,style: TextStyles.blueTextBoldSmall),
                        SizedBox(height: 16.0,),
                        Text('Start by adding your kids to unlock 3 playdates',textAlign: TextAlign.center,style: TextStyles.blackTextRegular,),
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/gift_bg.png"),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          child: Image(image: AssetImage('assets/gift.png'),alignment: Alignment.bottomCenter,),
                        ),
                        SizedBox(height: 16.0,),
                        ActionButtonView(
                          btnName: 'How to Page Link',
                          onBtnHit: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddChild()));
                          },
                          buttonStyle: TextStyles.stylePinkButton,
                        ),
                        SizedBox(height: 16.0,),
                        ActionButtonView(
                          btnName: 'Logout',
                          onBtnHit: () async {
                            await CustomBlocProvider.getBloc<AuthBloc>().signOut();
                            Navigator.pop(context);
                          },
                          buttonStyle: TextStyles.stylePinkButton,
                        ),
                        SizedBox(height: 30.0,),
                        /*Stack(
                          children: [
                            Positioned(
                            child: Image(image: AssetImage('assets/gift_bg.png')),
                            ),
                            Positioned(
                            child: Image(image: AssetImage('assets/gift.png')),
                            )
                          ],
                        ),*/

                      ],
                    ),
                  )
              ),
            ),
          );
        }
    );
  }

  Widget childListView(Child child) {
    return Container(
      width: 180.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/facebook_logo.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 20.0,
            decoration: const BoxDecoration(
              color: AppColors.color7059E1,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
          alignment: Alignment.bottomCenter,
            child: Text('${child.name}',style: TextStyles.whiteTextBold,textAlign: TextAlign.center,)
        ),
      ),
    );
  }
}
