import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/resources/color_manager.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    required this.valid,
    this.onChanged,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.phoneNumberPrefix = false,
  });

  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? valid;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final bool phoneNumberPrefix;

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: TextFormField(
          validator: widget.valid,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters ?? [],
          style: TextStyle(
            fontSize: 16,
            color: ColorManager.highEmphasis,
            fontWeight: FontWeight.w500,
          ),
          controller: widget.controller,
          textAlign: widget.textAlign,
          decoration: InputDecoration(
            prefixText: widget.phoneNumberPrefix ? "+98 " : '',
            prefixStyle: const TextStyle(color: Colors.black, fontSize: 16),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            hintText: widget.hintText,
            hintTextDirection: TextDirection.rtl,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintStyle: TextStyle(
              color: ColorManager.lowEmphasis,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
