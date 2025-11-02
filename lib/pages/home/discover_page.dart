import 'package:flutter/material.dart';
import '../search/search_page.dart';
import '../product/product_grid.dart';


class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        elevation: 1.0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Text(
          'Discover',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
            
            },
          ),
        ],
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[600]),
                          const SizedBox(width: 12),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.camera_alt_outlined, color: Colors.grey[600]),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[400]!),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.tune, color: Colors.grey[800]),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),

          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildCategoryCard(
                    context,
                    title: 'CLOTHING',
                    color: const Color(0xFFa9b0a2),
                    imagePath: 'assets/images/card1.png',
                  ),
                  const SizedBox(height: 16),
                  _buildCategoryCard(
                    context,
                    title: 'ACCESSORIES',
                    color: const Color(0xFFa19b98),
                    imagePath: 'assets/images/card2.png',
                  ),
                  const SizedBox(height: 16),
                  _buildCategoryCard(
                    context,
                    title: 'SHOES',
                    color: const Color(0xFF4e5c61),
                    imagePath: 'assets/images/card3.png',
                  ),
                  const SizedBox(height: 16),
                  _buildCategoryCard(
                    context,
                    title: 'COLLECTION',
                    color: const Color(0xFFbfb8bc),
                    imagePath: 'assets/images/card1.png',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required Color color,
    required String imagePath,
  }) {
    return GestureDetector(
      onTap: () {
      
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductGridScreen(category: title),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              color: color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  fontFamily: 'serif',
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 150,
                height: 140,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: 35,
                      child: Container(
                        width: 110,
                        height: 110,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 255, 255, 0.25),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(255, 255, 255, 0.45),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      child: ClipOval(
                        child: Image.asset(
                          imagePath,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
