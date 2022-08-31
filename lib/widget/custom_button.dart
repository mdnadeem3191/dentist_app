import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final double buttonWidth;
  final double buttonheight;
  final Color color;
  final double elevation;

  const CustomButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.buttonWidth,
    required this.buttonheight,
    required this.color,
    required this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation),
          backgroundColor: MaterialStateProperty.all(color),
          minimumSize: MaterialStateProperty.all(
            Size(buttonWidth, buttonheight),
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
      child: child,
    );
  }
}
