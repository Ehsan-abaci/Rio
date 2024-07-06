import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberTextFieldPage extends StatelessWidget {
  const PhoneNumberTextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.purple,
              Colors.deepPurple,
              Colors.blue.shade800,
            ],
            stops: const [0, 0.3, 0.8, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: PhoneNumberTextField(),
        ),
      ),
    );
  }
}

class PhoneNumberTextField extends StatefulWidget {
  PhoneNumberTextField({super.key});

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  final TextEditingController _controller = TextEditingController();

  RegExp pattern = RegExp(r'^9[0-9]{9}$');

  String formatNumber(String number) {
    number = number.replaceFirst(RegExp(r'^0+'), '');

    if (pattern.hasMatch(number.replaceAll(' ', ''))) {
      number = number.replaceAll(' ', '');
      return number
          .replaceAllMapped(RegExp(r".{7}$"), (match) => ' ${match[0]}')
          .replaceAllMapped(RegExp(r".{4}$"), (match) => ' ${match[0]}')
          .replaceAllMapped(RegExp(r".{2}$"), (match) => ' ${match[0]}');
    } else {
      return number;
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(13),
          ],
          validator: (value) {
            if (pattern.hasMatch(value?.replaceAll(' ', '') ?? "")) {
              return null;
            }
            return "Invalid number";
          },
          controller: _controller,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "915 123 45 67",
            hintStyle: TextStyle(color: Colors.white.withOpacity(.4)),
            errorStyle: const TextStyle(color: Colors.red, fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(.5),
          ),
          onChanged: (value) {
            _controller.text = formatNumber(value).trimRight();
          },
        ),
      ),
    );
  }
}
