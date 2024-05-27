import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(title: "تنظیمات"),
    );
  }
}
