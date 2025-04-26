import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Function onPressed;
  final double width;
  final Radius? borderRadius;
  final Widget child;
  final BoxShadow? shadow;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets? padding;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.width,
    this.backgroundColor,
    this.borderRadius,
    this.shadow,
    this.padding,
    this.boxShadow
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: width,
        padding: padding ?? EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(borderRadius ?? Radius.circular(20)),
          boxShadow: [
            shadow ??
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.35),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: Offset(0, 5),
                ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class CustomButtonOutline extends CustomButton {

  final Color? borderColor;

  const CustomButtonOutline({
    super.key,
    super.backgroundColor,
    required super.onPressed,
    required super.width,
    super.borderRadius,
    required super.child,
    super.shadow,
    super.padding,
    this.borderColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: width,
        padding: padding ?? EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Theme.of(context).primaryColor
          ),
          borderRadius: BorderRadius.all(borderRadius ?? Radius.circular(20)),
          boxShadow: [
            shadow ??
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.35),
                  blurRadius: 15,
                  spreadRadius: 0,
                  offset: Offset(0, 5),
                ),
          ],
        ),
        child: child,
      ),
    );
  }
}
