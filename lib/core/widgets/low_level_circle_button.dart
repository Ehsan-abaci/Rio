import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LowLevelCircleButton extends StatelessWidget {
  const LowLevelCircleButton(
      this.image, this.size, this.bgColor, this.frColor, this.onTap,
      {super.key});
  final void Function()? onTap;
  final String image;
  final double size;
  final Color bgColor;
  final Color frColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(size / 3.6),
        decoration: ShapeDecoration(
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(size),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x11000000),
              blurRadius: 8,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: SvgPicture.asset(
          image,
          color: frColor,
        ),
      ),
    );
  }
}
