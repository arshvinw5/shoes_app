import 'package:flutter/material.dart';

class PaymentHistory extends StatelessWidget {
  const PaymentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffef9f3),
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
            backgroundColor: Color(0xfffef9f3),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              centerTitle: false,
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LKR 5,270.00',
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
          //tool bar
          SliverAppBar(
            expandedHeight: 40,
            toolbarHeight: 40,
            pinned: true,
            //backgroundColor: Color(0xff060A0d),
            backgroundColor: Color(0xff000000),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildQuickActions(
                        onTap: () {}, icon: Icons.picture_as_pdf, text: 'PDF'),
                    const SizedBox(
                      width: 20.0,
                    ),
                    _buildQuickActions(
                        onTap: () {}, icon: Icons.find_in_page, text: 'Search'),
                    const SizedBox(
                      width: 20.0,
                    ),
                    _buildQuickActions(
                        onTap: () {}, icon: Icons.sort, text: 'Sort'),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Recnt Tranraction',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return _buildTransactionTile(
                title: 'Transcation : $index',
                subtitle: 'Details of transcation $index',
                amount: '${index.isEven ? '+' : '-'}LKR ${(index + 1) * 20}',
                isPositive: index.isEven);
          }, childCount: 20)),
          //we need this for footer
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 64,
                  color: Colors.black54,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Thank you for interact with the app',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildQuickActions({required onTap, required icon, required text}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20.0,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}

Widget _buildTransactionTile(
    {required String title,
    required String subtitle,
    required String amount,
    required isPositive}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: Card(
      color: Color(0xff000000),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xfffef9f3),
          child: Icon(
            isPositive ? Icons.arrow_upward : Icons.arrow_downward,
            color: isPositive ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey[700]),
        ),
        trailing: Text(
          amount,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isPositive ? Colors.green : Colors.red),
        ),
      ),
    ),
  );
}
