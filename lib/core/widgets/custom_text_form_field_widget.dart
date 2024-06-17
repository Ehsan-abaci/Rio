import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/resources/color_manager.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  const CustomTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.controllers,
    required this.valid,
    this.inputFormatters,
  });

  final String hintText;
  final TextEditingController controllers;
  final String? Function(String?)? valid;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: TextFormField(
          validator: widget.valid,
          inputFormatters: widget.inputFormatters ?? [],
          style: TextStyle(
              fontSize: 16,
              color: ColorManager.highEmphasis,
              fontWeight: FontWeight.w500),
          controller: widget.controllers,
          decoration: InputDecoration(
              hintText: widget.hintText,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: TextStyle(
                  color: ColorManager.lowEmphasis,
                  fontSize: 16,
                  fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
