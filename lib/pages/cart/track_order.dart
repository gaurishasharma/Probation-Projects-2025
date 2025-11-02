import 'package:flutter/material.dart';
// This import assumes you have the RateProductScreen in a file named this.
// This is the "connection" you asked for.
import 'rate_product.dart';

class TrackOrderScreen extends StatelessWidget {
  // You would pass the real tracking data into this screen
  const TrackOrderScreen({
    super.key,
    this.trackingNumber = "TYK256423878",
    this.deliveredOn = "15.05.21",
  });

  final String trackingNumber;
  final String deliveredOn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1, // A slight shadow as seen in the image
        shadowColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Track Order',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
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
              // --- 1. Header Info ---
              Text(
                'Delivered on : $deliveredOn',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 8),
              Text(
                'Tracking Number : $trackingNumber',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              // --- 2. Timeline ---
              // This is a hard-coded list for the UI.
              // In a real app, you'd build this from a List of status objects.
              Column(
                children: [
                  _buildStatusRow(
                    title: 'Parcel is successfully delivered',
                    date: '25 OCT 10:20',
                    isCurrent: true, // The top-most, current status
                  ),
                  _buildStatusRow(
                    title: 'Parcel is out for delivery',
                    date: '24 OCT 08:00',
                  ),
                  _buildStatusRow(
                    title: 'Parcel is received at delivery Branch',
                    date: '22 OCT 17:25',
                  ),
                  _buildStatusRow(
                    title: 'Parcel is in transit',
                    date: '21 OCT 07:00',
                  ),
                  _buildStatusRow(
                    title: 'Sender has shipped your parcel',
                    date: '21 OCT 14:25',
                  ),
                  _buildStatusRow(
                    title: 'Sender is preparing to ship your order',
                    date: '21 OCT 10:01',
                    isLast: true, // No dotted line after this
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // --- 3. Rating Card ---
              _buildRatingCard(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper widget to build a single row in the timeline
  Widget _buildStatusRow({
    required String title,
    required String date,
    bool isCurrent = false,
    bool isLast = false,
  }) {
    // This is the icon for a completed step
    IconData iconData = Icons.check_circle;
    Color iconColor = Colors.black;

    // This is the icon for the *current* (top) step
    if (isCurrent) {
      iconData = Icons.radio_button_checked;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Icon and Dotted Line Column ---
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: iconColor, size: 20),
              if (!isLast)
                Expanded(
                  // This is a simple solid line. A dotted line is
                  // more complex and requires a custom painter or package.
                  child: Container(
                    width: 2,
                    color: Colors.grey[300],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // --- Text Column ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
                // Add some padding at the bottom of each step
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget for the "Don't forget to rate" card
  Widget _buildRatingCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // --- THIS IS THE CONNECTION ---
        // It navigates to the RateProductScreen when tapped.
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RateProductScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Row(
          children: [
            // Using a standard reviews icon to approximate the custom one
            Icon(
              Icons.reviews_outlined,
              color: Colors.grey[700],
              size: 36,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Don't forget to rate",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rate product to get 5 points for collect.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // The static 5-star row
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star_border,
                        color: Colors.grey[400],
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
