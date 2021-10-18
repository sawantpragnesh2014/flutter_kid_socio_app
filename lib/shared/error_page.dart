import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

import 'app_bar_new.dart';

class ErrorPage extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback? onRetryPressed;

  ErrorPage({this.errorMessage = 'Some error occured', this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: AppStyles.getPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(errorMessage!,style: AppStyles.blackTextBold16,),
              SizedBox(height: 8.0,),
              ElevatedButton(
                  style:  AppStyles.stylePurpleButton,
                  onPressed: () {
                    onRetryPressed!();
                  }, child: Text('Retry',
                style: AppStyles.whiteTextBold16,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
