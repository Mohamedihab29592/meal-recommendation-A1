import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({super.key});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isChecked = !isChecked;
            });
          },
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.06,
            height: MediaQuery.sizeOf(context).height * 0.028,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white, // Border color
                width: 2,
              ),
              color: isChecked ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(4), // Square corners
            ),
            child: isChecked
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.black, // Checkmark color
                  )
                : null,
          ),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),
         Text(
          'Remember me and keep me logged in',
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.sizeOf(context).width * 0.033,
          ), // Text color
        ),
      ],
    );
  }
}
