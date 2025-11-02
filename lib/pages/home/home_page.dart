import 'package:commerce_sense/pages/home/discover_page.dart';
import 'package:flutter/material.dart';
import '../cart/cart.dart';
import '../profile/profile.dart';
import '../home/discover_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;


  late final List<Widget> _pages = [
    const _HomeContent(),
    const DiscoverScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
    );
  }
}



class _HomeContent extends StatelessWidget {
  const _HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Commerce Store',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainBanner(width),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Trending Now', 'Show all'),
              const SizedBox(height: 16),
              _buildTrendingNowList(context),
              const SizedBox(height: 24),
              _buildMidBanner(context),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Recommended', 'Show all'),
              const SizedBox(height: 16),
              _buildRecommendedList(context),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Top Collection', 'Show all'),
              const SizedBox(height: 16),
              _buildTopCollection(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Main Banner
  Widget _buildMainBanner(double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              'assets/images/homeback.png',
              height: 250,
              width: width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: const LinearGradient(
                colors: [Colors.transparent, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1.0],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Autumn Collection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '2025',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String actionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          Text(
            actionText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 12,
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }


  Widget _buildTrendingNowList(BuildContext context) {
    final items = [
      {'image': 'assets/images/card1.png', 'title': 'Turtleneck Sweater', 'price': '\$89.99'},
      {'image': 'assets/images/card2.png', 'title': 'Long Sleeve Dress', 'price': '\$49.99'},
      {'image': 'assets/images/card3.png', 'title': 'Sportswear Set', 'price': '\$80.00'},
    ];

    return SizedBox(
      height: 240,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: _buildProductCard(context, item['image']!, item['title']!, item['price']!),
          );
        },
      ),
    );
  }


  Widget _buildProductCard(BuildContext context, String image, String title, String price) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 5, offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.asset(image, height: 160, width: 160, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14)),
                const SizedBox(height: 4),
                Text(price,
                    style: const TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildMidBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AspectRatio(
        aspectRatio: 16 / 7,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('NEW COLLECTION', style: Theme.of(context).textTheme.bodySmall),
                      const SizedBox(height: 8),
                      Text(
                        'BAGS OUT & PARTY',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Image.asset('assets/images/card1.png', fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildRecommendedList(BuildContext context) {
    final items = [
      {'image': 'assets/images/card1.png', 'title': 'White Fusion Hoodie', 'price': '\$29.00'},
      {'image': 'assets/images/card2.png', 'title': 'Cotton Black T-Shirt', 'price': '\$30.00'},
      {'image': 'assets/images/card3.png', 'title': 'Blue Denim Jeans', 'price': '\$45.00'},
    ];

    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 8),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, i) {
          final item = items[i];
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: _buildRecommendedCard(context, item['image']!, item['title']!, item['price']!),
          );
        },
      ),
    );
  }
  Widget _buildRecommendedCard(BuildContext context, String image, String title, String price) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(price,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black54, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _buildTopCollection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildCollectionCard(
            context,
            subtitle: 'Sale up to 40%',
            title: 'FOR SLIM & BEAUTY',
            image: 'assets/images/card1.png',
            backgroundColor: Colors.grey[100]!,
            imageOnLeft: false,
          ),
          const SizedBox(height: 16),
          _buildCollectionCard(
            context,
            subtitle: 'Summer Collection 2025',
            title: 'Most sexy & religious design',
            image: 'assets/images/card2.png',
            backgroundColor: Colors.grey[900]!,
            textColor: Colors.white,
            imageOnLeft: false,
          ),
        ],
      ),
    );
  }


  Widget _buildCollectionCard(
    BuildContext context, {
    required String subtitle,
    required String title,
    required String image,
    required Color backgroundColor,
    Color textColor = Colors.black,
    bool imageOnLeft = true,
  }) {
    final children = [
      Expanded(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor)),
              const SizedBox(height: 8),
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontSize: 18, color: textColor)),
            ],
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: Image.asset(image, height: 150, fit: BoxFit.cover),
      ),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        color: backgroundColor,
        child: Row(children: imageOnLeft ? children : children.reversed.toList()),
      ),
    );
  }
}
