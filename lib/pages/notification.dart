import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
  });
}


class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<NotificationItem> todayNotifications = [
      NotificationItem(
        title: "30% Special Discount!",
        subtitle: "Special promotion only valid today",
        icon: Icons.percent, 
        iconColor: Colors.red,
        iconBackgroundColor: Colors.red,
      ),
      NotificationItem(
        title: "Your Order Has Been Taken by the Driver",
        subtitle: "Recently",
        icon: Icons.check,
        iconColor: Colors.green,
        iconBackgroundColor: Colors.green,
      ),
      NotificationItem(
        title: "Your Order Has Been Canceled",
        subtitle: "19 Jun 2023",
        icon: Icons.close,
        iconColor: Colors.red,
        iconBackgroundColor: Colors.red,
      ),
    ];

    final List<NotificationItem> yesterdayNotifications = [
      NotificationItem(
        title: "35% Special Discount!",
        subtitle: "Special promotion only valid today",
        icon: Icons.mail_outline, // Changed from envelope for discount
        iconColor: Colors.blue,
        iconBackgroundColor: Colors.blue,
      ),
      NotificationItem(
        title: "Account Setup Successfull!",
        subtitle: "Special promotion only valid today",
        icon: Icons.person,
        iconColor: Colors.blue,
        iconBackgroundColor: Colors.blue,
      ),
      NotificationItem(
        title: "Special Offer! 60% Off",
        subtitle: "Special offer for new account, valid until 20 Nov 2022",
        icon: Icons.percent, 
        iconColor: Colors.red,
        iconBackgroundColor: Colors.red,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, 
       
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        title: const Text(
          "Notification",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const Text(
                "Today",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: todayNotifications
                    .map((item) => NotificationTile(item: item))
                    .toList(),
              ),
              const SizedBox(height: 30), // Spacing between sections

            
              const Text(
                "Yesterday",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: yesterdayNotifications
                    .map((item) => NotificationTile(item: item))
                    .toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


class NotificationTile extends StatelessWidget {
  final NotificationItem item;

  const NotificationTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.icon,
              color: item.iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16), 

         
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4), 
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}