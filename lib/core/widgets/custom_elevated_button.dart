import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({
    super.key,
    required this.content,
    this.icon,
    required this.bgColor,
    required this.frColor,
    required this.borderRadius,
    this.borderColor,
    required this.width,
    required this.height,
    this.fontSize = 18,
    required this.onTap,
  });

  String content;
  String? icon;
  Color bgColor;
  Color frColor;
  double borderRadius;
  Color? borderColor;
  double fontSize;
  double width;
  double height;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: frColor,
            surfaceTintColor: bgColor,
            elevation: 0,
            fixedSize: Size(width / 2.5, height * .07),
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor ?? Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(
                borderRadius,
              ),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                if (icon != null)
                  SvgPicture.asset(
                    icon!,
                    color: frColor,
                  ),
                SizedBox(width: 5),
                Text(
                  content,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: fontSize,
                    color: frColor,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
