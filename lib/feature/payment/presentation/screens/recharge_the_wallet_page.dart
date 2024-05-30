import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_scooter/core/utils/extensions.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../widgets/circle_elevated_button.dart';

class RechargeTheWalletPage extends StatefulWidget {
  const RechargeTheWalletPage({super.key});

  @override
  State<RechargeTheWalletPage> createState() => _RechargeTheWalletPageState();
}

class _RechargeTheWalletPageState extends State<RechargeTheWalletPage> {
  int selected = 0;

  Widget customRadioButton(int index, String numberPlus, String number) {
    final width = MediaQuery.sizeOf(context).width;
    return Expanded(
      child: InkWell(
          onTap: () {
            setState(() {
              selected = index;
            });
          },
          child: Container(
            width: width * 0.45,
            decoration: BoxDecoration(
              color: ColorManager.surface,
              border: (selected == index)
                  ? Border.all(color: ColorManager.primary, width: 4)
                  : Border.all(color: ColorManager.border, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    child: Text(
                      "+ $numberPlus T",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  FittedBox(
                    child: Text(
                      "$number T",
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        color: ColorManager.highEmphasis,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: ColorManager.appBg,
      appBar: const CustomAppBarWidget(title: "شارژ کیف پول"),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              AssetsImage.bgBody,
              fit: BoxFit.cover,
              // width: MediaQuery.sizeOf(context).width * .4,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.04,
                    right: width * 0.04,
                    top: height * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "موجودی کیف پول",
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.highEmphasis),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${50000.0.to3Dot()} T",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            color: ColorManager.highEmphasis),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'اگر در هنگام سواری، موجودی کیف پول شما تمام شود؛ تا سواری بعدی باید اعتبار خود را شارژ نمائید.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.mediumEmphasis,
                          height: 1.8,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customRadioButton(1, "5.000", "50.000"),
                          const SizedBox(
                            width: 10,
                          ),
                          customRadioButton(0, "10.000", "100.000"),
                        ],
                      ),
                      const SizedBox(
                        height: 52,
                      ),
                      DesiredAmountCardWidget(width: width),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'به ازای مبالغ بالای 50.000 تومان، 10% جایزه به اعتبار شما افزوده می شود.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.mediumEmphasis,
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * .15,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * .15,
              width: double.infinity,
              padding: EdgeInsets.zero,
              color: ColorManager.appBg,
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.04,
                  right: width * 0.04,
                  bottom: height * 0.04,
                  top: height * 0.04,
                ),
                child: CustomElevatedButton(
                  onTap: () {},
                  content: "پرداخت اینترنتی",
                  fontSize: 16,
                  bgColor: ColorManager.primary,
                  frColor: Colors.white,
                  borderRadius: 12,
                  width: width,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DesiredAmountCardWidget extends StatelessWidget {
  const DesiredAmountCardWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.surfacePrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorManager.border,
          width: 1,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CustomElevatedButton(
                onTap: null,
                content: "مبلغ دلخواه",
                fontSize: 16,
                bgColor: ColorManager.primaryExtraLight,
                frColor: Colors.white,
                borderRadius: 12,
                width: width,
              ),
              const SizedBox(
                height: 15,
              ),
              CircleElevatedButton(
                onTap: () {},
                icon: AssetsIcon.add,
                bgColor: ColorManager.surface,
                frColor: ColorManager.primaryDark,
              ),
              const SizedBox(
                height: 17,
              ),
            ],
          )),
    );
  }
}
