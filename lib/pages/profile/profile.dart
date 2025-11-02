import 'package:commerce_sense/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../orders/orders_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 30, 30, 30),
        primaryColor: Colors.black,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey[400],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        iconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          titleMedium: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _bottomNavIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 32),
          Expanded(child: _buildNavigationCard()),
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
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.orangeAccent,
            child: Icon(Icons.person, color: Colors.white, size: 40),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Gaurisha', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                'gaurisha@gmail.com',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // MY ORDERS - Added here
            _buildListTile(
              icon: Icons.shopping_bag_outlined,
              title: 'My Orders',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyOrdersScreen(),
                  ),
                );
              },
            ),
            _buildListTile(
              icon: Icons.location_on_outlined,
              title: 'Address',
              onTap: () {},
            ),
            _buildListTile(
              icon: Icons.payment_outlined,
              title: 'Payment method',
              onTap: () {},
            ),
            _buildListTile(
              icon: Icons.local_offer_outlined,
              title: 'Voucher',
              onTap: () {},
            ),
            _buildListTile(
              icon: Icons.favorite_border_outlined,
              title: 'My Wishlist',
              onTap: () {},
            ),
            _buildListTile(
              icon: Icons.star_border_outlined,
              title: 'Rate this app',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[200]),
            const SizedBox(height: 16),
            _buildListTile(
              icon: Icons.logout_outlined,
              title: 'Log out',
              onTap: () {
                // Add your logout navigation here
              },
              hasTrailing: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool hasTrailing = true,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: Icon(icon, color: Theme.of(context).iconTheme.color),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: hasTrailing
          ? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400])
          : null,
      onTap: onTap,
    );
  }
}