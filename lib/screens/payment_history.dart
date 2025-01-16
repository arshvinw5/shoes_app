import 'package:flutter/material.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            toolbarHeight: 80,
            backgroundColor: Colors.black,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/cash.jpg',
                    fit: BoxFit.cover,
                  ),
                  // Adding a dark blend behind the title
                  Container(
                    decoration: BoxDecoration(color: Colors.black54),
                  ),
                ],
              ),
              title: Text(
                "Payment History",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ),
          ),
          SliverAppBar(
            expandedHeight: 200,
            toolbarHeight: 80,
            backgroundColor: Color(0xffF9F7F7),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              centerTitle: false,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\LKR 5,270.00',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 36),
                  ),
                  Text(
                    'Current Blance',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  )
                ],
              ),
              title: Text(
                'Total',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
          ),
          //we need this for footer
          SliverFillRemaining()
        ],
      ),
    );
  }
}
