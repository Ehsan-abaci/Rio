import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';

getRideImage(String? img) {
  return Expanded(
    flex: 3,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: (img != null)
              ? Image.memory(
                  Uint8List.fromList(base64Decode(img).toList()),
                  fit: BoxFit.cover,
                  width: 500,
                )
              : const Placeholder(),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ColorManager.appBg,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SvgPicture.asset(
              AssetsIcon.scooterAlt,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ],
    ),
  );
  return [];
}
