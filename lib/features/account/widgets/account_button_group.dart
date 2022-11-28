import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopBottonGroup extends StatefulWidget {
  const TopBottonGroup({Key? key}) : super(key: key);

  @override
  State<TopBottonGroup> createState() => _TopBottonGroupState();
}

class _TopBottonGroupState extends State<TopBottonGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onTap: () {}),
            AccountButton(text: "Turn Seller", onTap: () {}),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(text: "Log Out", onTap: () {}),
            AccountButton(text: "Wish List", onTap: () {}),
          ],
        ),
      ],
    );
  }
}
