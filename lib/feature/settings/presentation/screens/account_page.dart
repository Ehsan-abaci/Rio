import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_form_field_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_formatPhoneNumber);
  }

  void _formatPhoneNumber() {
    String value = _controller.text;
    if (value.startsWith('0')) {
      setState(() {
        _controller.value = TextEditingValue(
          text: '+98${value.substring(1)}',
          selection: TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length + 2),
          ),
        );
      });
    } else if (!value.startsWith('+98')) {
      setState(() {
        _controller.value = TextEditingValue(
          text: '+98$value',
          selection: TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length + 3),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final firstNameController = TextEditingController();
    final dateController = TextEditingController();
    final studentController = TextEditingController();
    final TextEditingController numberController =
        TextEditingController(text: "+98 915 756 88 97");

    return Scaffold(
      backgroundColor: ColorManager.appBg,
      appBar: const CustomAppBarWidget(title: "حساب کاربری"),
      body: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom * .2),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding:
                        const EdgeInsets.only(top: 24.0, right: 24, left: 24),
                    child: ListView(
                      children: [
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                                color: ColorManager.border, width: 1.0),
                          ),
                          color: ColorManager.surface,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                CustomTextFormFieldWidget(
                                  value: "text",
                                  errorText: "نام و نام خانوادکی نامعتبر",
                                  hintText: "نام و نام خانوادکی",
                                  nameController: firstNameController,
                                ),
                                Divider(
                                  color: ColorManager.border,
                                  thickness: 1,
                                ),
                                CustomTextFormFieldWidget(
                                  errorText: "تاریخ تولد نامعتبر",
                                  value: "date",
                                  hintText: "تاریخ تولد",
                                  nameController: dateController,
                                ),
                                Divider(
                                  color: ColorManager.border,
                                  thickness: 1,
                                ),
                                CustomTextFormFieldWidget(
                                  errorText: "کدملی / شماره دانشجویی نامعتبر",
                                  value: "nationalIdOrStudentNumber",
                                  hintText: "کدملی / شماره دانشجویی",
                                  nameController: studentController,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'شماره دانشجویی و یا کد ملی معتبر وارد نمائید.',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.mediumEmphasis,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(
                                color: ColorManager.border, width: 1.0),
                          ),
                          color: ColorManager.surface,
                          child: CustomTextFormFieldWidget(
                            errorText: "شماره تلفن نامعتبر",
                            // validate: _validatePhoneNumber,
                            value: "phone",
                            hintText: "شماره همراه",
                            nameController: numberController,
                          ),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: CustomElevatedButton(
          onTap: () {},
          content: "ذخیره",
          fontSize: 16,
          bgColor: ColorManager.primary,
          frColor: Colors.white,
          borderRadius: 12,
          width: width * .9,
        ),
      ),
    );
  }
}
