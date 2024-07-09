import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textFormFiled(_controller1),
                _textFormFiled(_controller2),
                _textFormFiled(_controller3),
                _textFormFiled(_controller4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFormFiled(TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: TextAlign.center,
          // textInputAction: TextInputAction.next,
          scrollPadding: EdgeInsets.zero,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          controller: controller,
          decoration: InputDecoration(
            counterText: "",
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor: controller.text.isEmpty
                ? ColorManager.surfaceTertiaryReverse
                : ColorManager.surface,
          ),
          onChanged: (value) {
            if (value.length == 1) {
              if (controller != _controller4)
                FocusScope.of(context).nextFocus();
            } else if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
            setState(() {});
          },
          onSaved: (newValue) => log(newValue.toString()),
        ),
      ),
    );
  }
}
