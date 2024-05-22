import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/feature/home/presentation/widgets/start_riding_modal.dart';

class UnlockingModal extends StatefulWidget {
  const UnlockingModal({super.key});

  @override
  State<UnlockingModal> createState() => _UnlockingModalState();
}

class _UnlockingModalState extends State<UnlockingModal> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) {
        if (mounted) {
          // context.read<RideBloc>().add(SetReadyToRide());
          Navigator.pop(context);
          showAdaptiveDialog(
            context: context,
            builder: (context) => StartRidingModal(),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Dialog(
      child: Container(
        height: height * .3,
        width: width * .75,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: ColorManager.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height * .01, horizontal: width * .04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset(
                          AssetsIcon.unlocked,
                          height: 32,
                          color: ColorManager.primaryExtraLight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "باز کردن قفل اسکوتر...",
                          style: TextStyle(
                            color: ColorManager.highEmphasis,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "گوشی را نزدیک اسکوتر نگه دارید و تا زمان نمایش پیام شروع سواری منتظر بمانید.",
                        style: TextStyle(
                          color: ColorManager.mediumEmphasis,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 0),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  CustomElevatedButton(
                    content: "لغو",
                    fontSize: 16,
                    bgColor: ColorManager.surface,
                    frColor: ColorManager.primaryDark,
                    borderColor: ColorManager.border,
                    borderRadius: 8,
                    width: width * .3,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
