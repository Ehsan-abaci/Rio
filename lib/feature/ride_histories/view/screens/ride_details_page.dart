import 'package:flutter/material.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import 'package:share_scooter/feature/ride_histories/model/ride_history_model.dart';
import 'package:share_scooter/feature/ride_histories/view/widgets/ride_image.dart';

import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';

class RideDetailsPage extends StatelessWidget {
  const RideDetailsPage({super.key, required this.rideHistoryModel});

  final RideHistoryModel rideHistoryModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.appBg,
      appBar: const CustomAppBarWidget(title: "جزئیات سواری"),
      body: WidgetColumnDetails(rideHistoryModel: rideHistoryModel),
    );
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
  const WidgetColumnDetails({super.key, required this.rideHistoryModel});
  final RideHistoryModel rideHistoryModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          getRideImage(rideHistoryModel.img),
          WidgetDetailsRow(
              title: "نوع دستگاه",
              description: rideHistoryModel.scooter.name,
              color: "black"),
          WidgetDetailsRow(
              title: "کد دستگاه",
              description: rideHistoryModel.scooter.id,
              color: "black"),
          const WidgetDivider(),
          WidgetDetailsRow(
              title: "زمان شروع",
              description:
                  '1403/03/06 ${rideHistoryModel.startTime.hour}:${rideHistoryModel.startTime.minute}',
              color: "black"),
          WidgetDetailsRow(
              title: "زمان پایان",
              description:
                  '1403/03/06 ${rideHistoryModel.endTime?.hour}:${rideHistoryModel.endTime?.minute}',
              color: "black"),
          WidgetDetailsRow(
              title: "مدت سواری",
              description:
                  '${Duration(milliseconds: rideHistoryModel.durationInMilliSeconds!).inMinutes} دقیقه',
              color: "black"),
          const WidgetDivider(),
          WidgetDetailsRow(
              title: "رزرو دستگاه",
              description: '${rideHistoryModel.reservationCost.to3Dot()} T',
              color: "red"),
          WidgetDetailsRow(
              title: "سواری",
              description: '${rideHistoryModel.ridingCost?.to3Dot()} T',
              color: "red"),
          WidgetDetailsRow(
              title: "مالیات (%10)",
              description: '${rideHistoryModel.tax?.to3Dot()}  T',
              color: "red"),
          WidgetDetailsRow(
              title: "جمع هزینه ها",
              description: '${rideHistoryModel.totalCost?.to3Dot()}  T',
              color: "red"),
          const WidgetDivider(),
          const WidgetDetailsRow(
            title: "موجودی کیف پول",
            description: '8.600 T',
            color: "green",
          ),
          const WidgetDetailsRow(
            title: "پرداخت اینترنتی",
            description: '20.000 T',
            color: "green",
          ),
        ],
      ),
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
            fontSize: 16,
          ),
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
