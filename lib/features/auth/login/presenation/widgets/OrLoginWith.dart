import 'package:flutter/material.dart';

class OrLoginWith extends StatelessWidget {
  const OrLoginWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 10,
          ),
        ),
        Text(
          "or login with",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.sizeOf(context).width * 0.045,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 10,
            endIndent: 20,
          ),
        ),
      ],
    );
  }
}
