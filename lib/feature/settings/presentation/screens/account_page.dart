import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBarWidget(title: "حساب کاربری"),
    );
  }
}
