import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

import '../bottom_nav.dart';

class Policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
          child: Container(
            height: SizeConfig.blockSizeVertical*80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Privacy Policy',style: AppStyles.blackTextBold16,),
                SizedBox(height: 10,),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Text('ed ut perspiciatis unde omnisiste natus error sit voluptatemaccusantium doloremque laudantiu, totam rem aperiam, eaque ipsaquae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.Nemo enim ipsam voluptatemquia voluptas sit aspernaturaut odit aut fugit, sed quiaconsequuntur magni dolores eosqui ratione voluptatem sequinesciunt. Neque porro quisquamest, qui dolorem ipsum quiadolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora ed ut perspiciatis unde omnisiste natus error sit voluptatemaccusantium doloremque laudantiuerspiciatis unde omnisiste natus error sit voluptatemaccusantium doloremque laudantiuerspiciatis unde omnisiste natus error sit voluptatemaccusantium doloremque laudantiuerspiciatis unde omnisiste natus error sit voluptatemaccusantium doloremque laudantiuerspiciatis unde omnisiste natus error sit voluptatemaccusantium doloremque laudantiuerspiciatis unde omnisiste natus error sit voluptatemaccusantium doloremque laudantiu, totam rem aperiam, eaque ipsaquae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.Nemo enim ipsam voluptatemquia voluptas sit aspernaturaut odit aut fugit, sed quiaconsequuntur magni dolores eosqui ratione voluptatem sequinesciunt. Neque porro quisquamest, qui dolorem ipsum quiadolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora',style: AppStyles.paragraphText,),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(child: Text('By continuing you agree to our Privacy Policy',style: AppStyles.kSubTitleStyle,)),
                SizedBox(height: 10,),
                ActionButtonView(btnName: 'Continue',onBtnHit: () => Navigator.pop(context),)
              ],
            ),
          ),
           ),
    );
  }
}
