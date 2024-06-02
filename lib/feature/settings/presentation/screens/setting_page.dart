import 'package:flutter/material.dart';
import 'package:share_scooter/feature/settings/presentation/screens/terms_of_use_page.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../../../../core/widgets/custom_appbar_widget.dart';
import 'account_page.dart';
import 'change_language_page.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarWidget(title: "تنظیمات"),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: ColorManager.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ColorManager.border,
                      width: 1,
                    )),
                child: Column(
                  children: [
                    ListTileSetting(
                      title: 'حساب کاربری',
                      leading: Icons.account_circle,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AccountPage()));
                      },
                    ),
                    Divider(
                      color: ColorManager.border,
                      thickness: 1,
                    ),
                    ListTileSetting(
                      title: 'تغییر زبان',
                      leading: Icons.language,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ChangeLanguagePage()));
                      },
                    ),
                    ListTileSetting(
                      title: 'شرایط استفاده',
                      leading: Icons.text_snippet_rounded,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TermsOfUsePage()));
                      },
                    ),
                    ListTileSetting(
                      title: 'حریم خصوصی',
                      leading: Icons.privacy_tip,
                      onTap: () {},
                    ),
                    Divider(
                      color: ColorManager.border,
                      thickness: 1,
                    ),
                    ListTileSetting(
                      title: 'خروج از حساب کاربری',
                      leading: Icons.exit_to_app,
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class ListTileSetting extends StatelessWidget {
  const ListTileSetting({super.key,
    required this.title,
    required this.leading,
    required this.onTap});

  final String title;
  final IconData leading;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: ColorManager.highEmphasis,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(
          leading,
          color: ColorManager.placeholder,
          size: 24,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: ColorManager.placeholder,
          size: 24,
        ),
        onTap: onTap,
      ),
    );
  }
}
