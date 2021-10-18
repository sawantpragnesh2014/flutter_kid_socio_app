import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class ActionButtonView extends StatelessWidget {
  final VoidCallback onBtnHit;
  final String btnName;
  final ButtonStyle? buttonStyle;

  ActionButtonView({required this.btnName,required this.onBtnHit,this.buttonStyle});

  @override
  Widget build(BuildContext context) {
    return _actionButton;
  }

  Widget get _actionButton {
    return Padding(
      padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
      child: SizedBox(
        height: 60.0,
        width: double.infinity,
        child: ElevatedButton(
          style: buttonStyle??AppStyles.stylePurpleButton,
          onPressed: () {
            onBtnHit();
          },
          child: Text(
            btnName,
            style: AppStyles.whiteTextBold16,
          ),
        ),
      ),
    );
  }
}
