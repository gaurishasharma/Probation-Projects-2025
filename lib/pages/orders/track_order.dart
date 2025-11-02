import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Track Order',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Date
              Row(
                children: [
                  Text(
                    'Delivered on: ',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    '3.03.21',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Tracking Number
              Row(
                children: [
                  Text(
                    'Tracking Number: ',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    'TYX2546428878',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Tracking Timeline
              _buildTrackingStep(
                icon: Icons.check_circle,
                title: 'Parcel is successfully delivered',
                time: '24.10.17 10:00',
                isActive: true,
                isFirst: true,
              ),
              
              _buildTrackingStep(
                icon: Icons.check_circle,
                title: 'Parcel is out for delivery',
                time: '24.10.17 10:00',
                isActive: true,
              ),
              
              _buildTrackingStep(
                icon: Icons.check_circle,
                title: 'Parcel is received at delivery branch',
                time: '24.10.17 10:00',
                isActive: true,
              ),
              
              _buildTrackingStep(
                icon: Icons.check_circle,
                title: 'Parcel is in transit',
                time: '24.10.17 10:00',
                isActive: true,
              ),
              
              _buildTrackingStep(
                icon: Icons.check_circle,
                title: 'Parcel has shipped your parcel',
                time: '24.10.17 10:00',
                isActive: true,
              ),
              
              _buildTrackingStep(
                icon: Icons.shopping_bag_outlined,
                title: 'Parcel is preparing to ship your order',
                time: '24.10.17 10:00',
                isActive: true,
                isLast: true,
              ),
              
              const SizedBox(height: 40),
              
              // Rating Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.thumbs_up_down_outlined,
                        color: Colors.orange[800],
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Don\'t forget to rate',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Give feedback to give a better the delivery',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingStep({
    required IconData icon,
    required String title,
    required String time,
    required bool isActive,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Column
        Column(
          children: [
            // Top Line
            if (!isFirst)
              Container(
                width: 2,
                height: 20,
                color: isActive ? Colors.black : Colors.grey[300],
              ),
            
            // Icon
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isActive ? Colors.black : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 16,
              ),
            ),
            
            // Bottom Line
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isActive ? Colors.black : Colors.grey[300],
              ),
          ],
        ),
        
        const SizedBox(width: 15),
        
        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isActive ? Colors.black : Colors.grey[400],
                    fontSize: 14,
                    fontWeight: isFirst ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}