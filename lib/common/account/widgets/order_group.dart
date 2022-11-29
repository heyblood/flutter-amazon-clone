import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/common/account/widgets/order_card.dart';
import 'package:flutter/material.dart';

// TODO replace with real product info list
const productList = [
  "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGhvbmV8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1557180295-76eee20ae8aa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHBob25lfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
  "https://images.unsplash.com/photo-1554672408-730436b60dde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fHBob25lfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
];

class OrderGroup extends StatefulWidget {
  const OrderGroup({Key? key}) : super(key: key);

  @override
  State<OrderGroup> createState() => _OrderGroupState();
}

class _OrderGroupState extends State<OrderGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                "See All",
                style: TextStyle(color: GlobalVarialbles.selectedNavBarColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // display orders
        Container(
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderCard(imageUrl: productList.elementAt(index));
            },
          ),
        ),
      ],
    );
  }
}
