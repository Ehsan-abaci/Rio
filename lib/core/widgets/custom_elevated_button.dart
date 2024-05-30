import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomElevatedButton extends StatelessWidget {
 const CustomElevatedButton({
    super.key,
    required this.content,
    this.icon,
    required this.bgColor,
    required this.frColor,
    required this.borderRadius,
    this.borderColor,
    required this.width,
    this.fontSize = 18,
    required this.onTap,
  });

  final String content;
  final String? icon;
  final Color bgColor;
  final Color frColor;
  final double borderRadius;
  final Color? borderColor;
  final double fontSize;
  final double width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: frColor,
          surfaceTintColor: bgColor,
          elevation: 0,
          fixedSize: Size(width, height * 0.06),
          padding: EdgeInsets.symmetric(
              vertical: height * .01, horizontal: width * .04),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(
              borderRadius,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                if (icon != null)
                  Row(
                    children: [
                      SvgPicture.asset(
                        icon!,
                        color: frColor,
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: fontSize,
                        color: frColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
