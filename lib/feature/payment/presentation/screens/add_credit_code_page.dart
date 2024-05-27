import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/resources/assets_manager.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class AddCreditCodePage extends StatelessWidget {
  const AddCreditCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
        appBar: const CustomAppBarWidget(title: "افزودن کد اعتبار"),
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
              child: Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.04,
                    right: width * 0.04,
                    top: height * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        initialValue: "AZSDF432AA",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.highEmphasis,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorManager.reversedEmphasis,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager.border,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager.border,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'کد اعتبار خود را وارد نمائید. در صورت معتبر بودن کد برای شما اعمال می شود',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.mediumEmphasis,
                          height: 1.8,
                        ),
                      )
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: width * 0.04,
                  right: width * 0.04,
                  bottom: height * 0.04,
                ),
                child: CustomElevatedButton(
                  onTap: () {},
                  content: "تایید",
                  fontSize: 16,
                  bgColor: ColorManager.primary,
                  frColor: Colors.white,
                  borderRadius: 12,
                  width: width,
                ),
              ),
            ),
          ],
        ));
  }
}
