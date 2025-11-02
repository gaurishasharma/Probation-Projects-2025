import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Orders Screen',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // ✅ Correct: Use TabBarThemeData instead of TabBarTheme
        tabBarTheme: const TabBarThemeData(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          dividerColor: Colors.transparent, // cleaner design
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF333333),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: const Color(0xFF1E1E1E),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[600],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
      home: const MyOrdersScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _bottomNavIndex = 2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 2,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          title: const Text('My Orders'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TabBar(
                  indicator: BoxDecoration(
                    color: Color(0xFF444444),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                  indicatorPadding: EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: -4.0,
                  ),
                  tabs: [
                    Tab(text: 'Pending'),
                    Tab(text: 'Delivered'),
                    Tab(text: 'Cancelled'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildPendingOrdersList(),
            _buildDeliveredOrdersList(),
            _buildCancelledOrdersList(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Bag',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingOrdersList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildOrderCard(
          orderNumber: '#1524',
          date: '10/02/2025',
          trackingNumber: 'IK287368838',
          quantity: 2,
          subtotal: 110.0,
          status: OrderStatus.pending,
        ),
        const SizedBox(height: 16),
        _buildOrderCard(
          orderNumber: '#1525',
          date: '11/02/2025',
          trackingNumber: 'IK2873218897',
          quantity: 3,
          subtotal: 230.0,
          status: OrderStatus.pending,
        ),
      ],
    );
  }

  Widget _buildDeliveredOrdersList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildOrderCard(
          orderNumber: '#1514',
          date: '30/08/2025',
          trackingNumber: 'TY987362341',
          quantity: 2,
          subtotal: 110.0,
          status: OrderStatus.delivered,
        ),
        const SizedBox(height: 16),
        _buildOrderCard(
          orderNumber: '#1679',
          date: '15/05/2025',
          trackingNumber: 'KYP873218890',
          quantity: 3,
          subtotal: 450.0,
          status: OrderStatus.delivered,
        ),
      ],
    );
  }

  Widget _buildCancelledOrdersList() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildOrderCard(
          orderNumber: '#8864',
          date: '20/10/2025',
          trackingNumber: 'TYK256543878',
          quantity: 2,
          subtotal: 110.0,
          status: OrderStatus.cancelled,
        ),
      ],
    );
  }

  Widget _buildOrderCard({
    required String orderNumber,
    required String date,
    required String trackingNumber,
    required int quantity,
    required double subtotal,
    required OrderStatus status,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order $orderNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: Colors.grey[700]),
          const SizedBox(height: 8),
          _buildInfoRow('Tracking number:', trackingNumber),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoRow('Quantity:', '$quantity'),
              _buildInfoRow('Subtotal:', '\$${subtotal.toStringAsFixed(0)}'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status.name,
                style: TextStyle(
                  color: status.color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey[600]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                ),
                child: const Text('Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(color: Colors.grey[400], fontSize: 14),
        children: [
          TextSpan(text: '$label '),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

enum OrderStatus {
  pending,
  delivered,
  cancelled;

  String get name {
    switch (this) {
      case OrderStatus.pending:
        return 'PENDING';
      case OrderStatus.delivered:
        return 'DELIVERED';
      case OrderStatus.cancelled:
        return 'CANCELLED';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orangeAccent;
      case OrderStatus.delivered:
        return Colors.greenAccent;
      case OrderStatus.cancelled:
        return Colors.redAccent;
    }
  }
}
