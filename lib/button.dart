import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final value;
  final textcolor;
  final buttoncolor;
  final tap;

  Button({this.buttoncolor, this.value, this.textcolor, this.tap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60.0),
          child: Container(
            height: 10,
            width: 10,
            color: buttoncolor,
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                    color: textcolor, fontSize: 24, fontFamily: 'Silkscreen'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
