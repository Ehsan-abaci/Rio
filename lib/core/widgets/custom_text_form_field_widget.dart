import 'package:flutter/material.dart';
import '../utils/resources/color_manager.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  const CustomTextFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.nameController,
      required this.errorText,
      required this.value});

  final String hintText;
  final TextEditingController nameController;
  final String errorText;
  final String value;

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  final _phoneRegExp = RegExp(r'^(?:\+98|0)?9\d{9}$');
  final RegExp nationalIdOrStudentNumberRegExp = RegExp(r'^\d{1,10}$');
  final RegExp dateRegExp = RegExp(r'^\d{4}/\d{2}/\d{2}$');
  final RegExp anyRegExp = RegExp(r'.*');
  String? _errorText;

  void _validatePhoneNumber(String value) {
    setState(() {
      if (widget.value == "phone"
          ? _phoneRegExp.hasMatch(value)
          : widget.value == "nationalIdOrStudentNumber"
              ? nationalIdOrStudentNumberRegExp.hasMatch(value)
              : widget.value == "date"
                  ? dateRegExp.hasMatch(value)
                  : widget.value == "text"
                      ? anyRegExp.hasMatch(value)
                      : anyRegExp.hasMatch(value)) {
        _errorText = null;
      } else {
        _errorText = widget.errorText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2
      ),
      child: TextFormField(
        keyboardType: widget.value == "phone"
            ? TextInputType.phone
            : widget.value == "date"
                ? TextInputType.datetime
                : TextInputType.name,
        onChanged: _validatePhoneNumber,
        style: TextStyle(
            fontSize: 16,
            color: ColorManager.highEmphasis,
            fontWeight: FontWeight.w500),
        controller: widget.nameController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            errorText: _errorText,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: ColorManager.lowEmphasis,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
