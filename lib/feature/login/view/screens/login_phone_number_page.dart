import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/core/utils/resources/assets_manager.dart';
import 'package:share_scooter/core/utils/resources/color_manager.dart';
import 'package:share_scooter/core/utils/resources/functions.dart';
import 'package:share_scooter/core/utils/resources/routes_manager.dart';
import 'package:share_scooter/core/widgets/custom_elevated_button.dart';
import 'package:share_scooter/core/widgets/custom_text_form_field_widget.dart';
import 'package:share_scooter/feature/payment/model/account_model.dart';

class LoginPhoneNumberPage extends StatelessWidget {
  LoginPhoneNumberPage({super.key});

  final _phoneNumberController = TextEditingController();

  final _nameController = TextEditingController();

  AccountModel _accountModel = AccountModel();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    final w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: 0, child: SvgPicture.asset(AssetsImage.bgBody)),
          Positioned(
            top: h * 0.08,
            right: 20,
            left: 20,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(
                    AssetsIcon.back,
                    matchTextDirection: true,
                  ),
                ),
                SizedBox(height: h * 0.05),
                SvgPicture.asset(
                  AssetsImage.logo,
                  height: 30,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(height: h * 0.05),
                const Text(
                  "ورود با شماره تلفن همراه",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: h * 0.05),
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: ColorManager.border, width: 1.0),
                  ),
                  child: CustomTextFormFieldWidget(
                    hintText: "نام و نام خانوادگی",
                    controller: _nameController,
                    onChanged: (val) => _accountModel =
                        _accountModel.copyWith(name: _nameController.text),
                    valid: null,
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: ColorManager.border, width: 1.0),
                  ),
                  color: ColorManager.surface,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomTextFormFieldWidget(
                      textAlign: TextAlign.start,
                      controller: _phoneNumberController,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(13),
                      ],
                      phoneNumberPrefix: true,
                      hintText: "شماره همراه خود را وارد نمائید...",
                      onChanged: (val) {
                        _phoneNumberController.text =
                            formatNumber(val).trimRight();
                        _accountModel = _accountModel.copyWith(phone: val);
                      },
                      valid: (val) {
                        if (val == null || val.isEmpty) {
                          return 'لطفا شماره تلفن خود را وارد کنید';
                        } else if (!phoneRegExp
                            .hasMatch(val.replaceAll(' ', ''))) {
                          return 'شماره تلفن معتبر نیست';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  content: 'ورود',
                  bgColor: ColorManager.primary,
                  frColor: ColorManager.white,
                  borderRadius: 12,
                  width: w,
                  onTap: () async {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.homeRoute,
                      ModalRoute.withName(Routes.splashRoute),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
