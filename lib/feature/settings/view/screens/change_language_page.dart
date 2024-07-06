import 'package:flutter/material.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import '../../../../core/widgets/custom_elevated_button.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late String _selectedLanguage = 'فارسی';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: ColorManager.appBg,
        appBar: const CustomAppBarWidget(title: "تغییر زبان"),
        body: Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: const EdgeInsets.all(24.0),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                RadioListTileWidget(
                                  title: 'فارسی',
                                  groupValue: _selectedLanguage,
                                  onTap: (value) {
                                    setState(() {
                                      _selectedLanguage = value!;
                                    });
                                  },
                                ),
                                RadioListTileWidget(
                                  title: 'English',
                                  groupValue: _selectedLanguage,
                                  onTap: (value) {
                                    setState(() {
                                      _selectedLanguage = value!;
                                    });
                                  },
                                ),
                                RadioListTileWidget(
                                  title: 'Türkçe',
                                  groupValue: _selectedLanguage,
                                  onTap: (value) {
                                    setState(() {
                                      _selectedLanguage = value!;
                                    });
                                  },
                                ),
                                RadioListTileWidget(
                                  title: 'عربی',
                                  groupValue: _selectedLanguage,
                                  onTap: (value) {
                                    setState(() {
                                      _selectedLanguage = value!;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ))),
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
                  content: "ذخیره",
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

class RadioListTileWidget extends StatelessWidget {
  const RadioListTileWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.groupValue});

  final String title;
  final String groupValue;
  final void Function(String?) onTap;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        title: Text(title),
        value: title,
        groupValue: groupValue,
        onChanged: onTap);
  }
}
