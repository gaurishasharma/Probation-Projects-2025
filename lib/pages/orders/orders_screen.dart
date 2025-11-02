import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: const Color(0xFF4A5568),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Go back to profile
            },
          ),
          title: const Text(
            'My Orders',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Delivered'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPendingOrders(),
            _buildDeliveredOrders(),
            _buildCancelledOrders(),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildOrderCard(
          orderNumber: '#1524',
          date: '10/02/2025',
          trackingNumber: 'IK287568838',
          quantity: 3,
          subtotal: '\$110',
          status: 'PENDING',
          statusColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildOrderCard(
          orderNumber: '#1523',
          date: '10/02/2025',
          trackingNumber: 'IK267818927',
          quantity: 3,
          subtotal: '\$230',
          status: 'PENDING',
          statusColor: Colors.orange,
        ),
        const SizedBox(height: 12),
        _buildOrderCard(
          orderNumber: '#1524',
          date: '10/02/2025',
          trackingNumber: 'IK237568820',
          quantity: 5,
          subtotal: '\$490',
          status: 'PENDING',
          statusColor: Colors.orange,
        ),
      ],
    );
  }

  Widget _buildDeliveredOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildOrderCard(
          orderNumber: '#1514',
          date: '30/08/2025',
          trackingNumber: 'TY987652341',
          quantity: 2,
          subtotal: '\$110',
          status: 'DELIVERED',
          statusColor: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildOrderCard(
          orderNumber: '#1679',
          date: '15/03/2025',
          trackingNumber: 'FYP87218830',
          quantity: 3,
          subtotal: '\$450',
          status: 'DELIVERED',
          statusColor: Colors.green,
        ),
        const SizedBox(height: 12),
        _buildOrderCard(
          orderNumber: '#1671',
          date: '21/03/2025',
          trackingNumber: 'TY41F868881',
          quantity: 3,
          subtotal: '\$400',
          status: 'DELIVERED',
          statusColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildCancelledOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildOrderCard(
          orderNumber: '#8864',
          date: '20/10/2025',
          trackingNumber: 'TY23564387R',
          quantity: 2,
          subtotal: '\$110',
          status: 'CANCELED',
          statusColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildOrderCard({
    required String orderNumber,
    required String date,
    required String trackingNumber,
    required int quantity,
    required String subtotal,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order $orderNumber',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Tracking number:  ',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  trackingNumber,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Quantity:  ',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Subtotal:  ',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      subtotal,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    'Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}