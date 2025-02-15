import 'package:flutter/material.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.errorTitle,
    required this.errorDesc,
    this.retryActionFunction,
  });
  final String errorTitle;
  final String errorDesc;
  final Function()? retryActionFunction;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return PopScope(
      canPop: false,
      child: Dialog(
        child: Container(
          height: height * .2,
          width: width < 600 ? width * .8 : 450,
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
                      vertical: height * .02, horizontal: width * .05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            errorTitle,
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
                        flex: 3,
                        child: Text(
                          errorDesc,
                          style: TextStyle(
                            color: ColorManager.mediumEmphasis,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.center,
                            child: CustomElevatedButton(
                              onTap: retryActionFunction ??
                                  () => Navigator.pop(context),
                              content: retryActionFunction != null
                                  ? "تلاش مجدد"
                                  : "بستن",
                              bgColor: ColorManager.surfacePrimary,
                              frColor: ColorManager.primaryDark,
                              width: width,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
