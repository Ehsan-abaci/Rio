import 'package:flutter/material.dart';
import 'package:share_scooter/core/widgets/custom_appbar_widget.dart';
import '../widgets/active_gift_credit.dart';
import '../widgets/active_saved_card.dart';
import '../widgets/gift_credit.dart';
import '../widgets/saved_card.dart';
import '../widgets/wallet_balance.dart';

class CreditPaymentPage extends StatelessWidget {
  const CreditPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarWidget(title: "پرداخت اعتباری"),
        body: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: ListView(
            children: const [
              WalletBalance(),
              SavedCard(),
              ActiveSavedCard(),
              GiftCredit(),
              ActiveGiftCredit()
            ],
          ),
        ));
  }
}
