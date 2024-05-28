import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleElevatedButton extends StatelessWidget {
  const CircleElevatedButton({
    super.key,
    this.icon,
    required this.bgColor,
    required this.frColor,
    required this.onTap,
  });

  final String? icon;
  final Color bgColor;
  final Color frColor;

  final void Function()? onTap;

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
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(18),
          ),
          child: SvgPicture.asset(
            icon!,
            color: frColor,
          )),
    );
  }
}