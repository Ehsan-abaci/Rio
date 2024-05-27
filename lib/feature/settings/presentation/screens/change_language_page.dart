import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(title: "Change Language"),
    );
  }
}
