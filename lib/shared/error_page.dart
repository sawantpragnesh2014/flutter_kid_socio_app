import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetryPressed;

  ErrorPage({this.errorMessage, this.onRetryPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(errorMessage),
          SizedBox(height: 8.0,),
          ElevatedButton(
              style:  AppStyles.stylePurpleButton,
              onPressed: () {
                onRetryPressed();
              }, child: Text('Retry',
            style: AppStyles.whiteTextBold16,
          ),)
        ],
      ),
    );
  }
}
