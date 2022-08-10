import 'package:flutter/material.dart';
import 'package:kodatel/constant.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key, required this.height, required this.width, required this.text})
      : super(key: key);
  final double height;
  final double width;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding,
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(padding + 20)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: foregroundColor, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
