import 'package:flutter/material.dart';

import '../../../../../core/routing/routes.dart';

class NoAccountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width * 0.038,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.register);
          },
          child: Text(
            'Register Now',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.sizeOf(context).width * 0.042,
            ),
          ),
        ),
      ],
    );
  }
}
