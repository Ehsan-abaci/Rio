import 'package:flutter/material.dart';
import 'package:share_scooter/core/widgets/custom_appbar_widget.dart';
import '../../../../core/utils/resources/color_manager.dart';
import '../widgets/credit_cards_widget.dart';

class CreditPaymentPage extends StatelessWidget {
  const CreditPaymentPage({super.key});


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBarWidget(title:"پرداخت اعتباری"),
body: Padding(
  padding: const EdgeInsets.only(top: 24),
  child: ListView(
    children: const[
      CreditCardsWidget(savedCard: true,activeSavedCard: true,),
      CreditCardsWidget(giftCredit: true,activeGiftCredit: true,),
      CreditCardsWidget(walletBalance: true,),
      CreditCardsWidget(savedCard: true,),
      CreditCardsWidget(giftCredit: true,),


    ],
  ),
)
    );
  }
}
