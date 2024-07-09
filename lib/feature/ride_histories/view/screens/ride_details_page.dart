import 'package:flutter/material.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';

class RideDetailsPage extends StatelessWidget {
  const RideDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.appBg,
        appBar: const CustomAppBarWidget(title: "جزئیات سواری"),
        body: const WidgetColumnDetails());
  }
}

class WidgetDivider extends StatelessWidget {
  const WidgetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorManager.border,
      thickness: 1,
    );
  }
}

class WidgetColumnDetails extends StatelessWidget {
  const WidgetColumnDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(children: [
        WidgetDetailsRow(
            title: "نوع دستگاه", description: 'E-Scooter', color: "black"),
        WidgetDetailsRow(
            title: "کد دستگاه", description: '342R', color: "black"),
        WidgetDivider(),
        WidgetDetailsRow(
            title: "زمان شروع",
            description: '1403/03/06 20:49',
            color: "black"),
        WidgetDetailsRow(
            title: "زمان پایان",
            description: '1403/03/06 21:05',
            color: "black"),
        WidgetDetailsRow(
            title: "مدت سواری", description: '16 دقیقه', color: "black"),
        WidgetDivider(),
        WidgetDetailsRow(
            title: "رزرو دستگاه", description: '1000 T', color: "red"),
        WidgetDetailsRow(title: "سواری", description: '25.000 T', color: "red"),
        WidgetDetailsRow(
            title: "مالیات (%10)", description: '2.600 T', color: "red"),
        WidgetDetailsRow(
            title: "جمع هزینه ها", description: '28.600 T', color: "red"),
        WidgetDivider(),
        WidgetDetailsRow(
            title: "موجودی کیف پول", description: '8.600 T', color: "green"),
        WidgetDetailsRow(
            title: "پرداخت اینترنتی", description: '20.000 T', color: "green"),
      ]),
    );
  }
}

class WidgetDetailsRow extends StatelessWidget {
  const WidgetDetailsRow(
      {super.key,
      required this.title,
      required this.description,
      required this.color});

  final String title;
  final String description;
  final String color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorManager.highEmphasis,
              fontSize: 16),
        ),
        Text(
          description,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: _getColor(color),
              fontSize: 16),
        )
      ]),
    );
  }
  Color _getColor(String color) {
    switch (color) {
      case "red":
        return ColorManager.red;
      case "green":
        return ColorManager.green;
      default:
        return ColorManager.highEmphasis;
    }
  }
}
