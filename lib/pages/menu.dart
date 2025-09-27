import 'package:flutter/material.dart';
import 'notification.dart'; // <-- 1. ADD THIS IMPORT
import 'details.dart';
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedCategory = 0;
  int bottomIndex = 0;

  final List<Map<String, String>> foodItems = [
    {
      "name": "Ordinary Burgers",
      "image": "assets/images/burger1.jpg",
      "rating": "4.9",
      "distance": "190m",
      "price": "250",
    },
    {
      "name": "Burger With Meat",
      "image": "assets/images/burger2.jpg",
      "rating": "4.9",
      "distance": "190m",
      "price": "330",
    },
    {
      "name": "Special Burger",
      "image": "assets/images/images.jpg",
      "rating": "4.8",
      "distance": "200m",
      "price": "500",
    },
    {
      "name": "Cheese Burger",
      "image": "assets/images/images.jpeg",
      "rating": "4.7",
      "distance": "220m",
      "price": "600",
    },
  ];

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Stack(
              children: [
                Container(
                  height: 240,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/top-view-delicious-hot-dogs-frame.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

              
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),

              
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Your Location",
                              style:
                                  TextStyle(color: Colors.white70, fontSize: 14)),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.orange, size: 18),
                              SizedBox(width: 4),
                              Text("New York City",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.search, size: 26, color: Colors.white),
                      const SizedBox(width: 16),
                      
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined, 
                            size: 26,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const Positioned(
                  left: 20,
                  bottom: 20,
                  child: Text(
                    "Provide the best\nfood for you",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(1, 1),
                        
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text("Find by Category",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text("See All",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            const SizedBox(height: 12),

          
           

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                  itemCount: foodItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final food = foodItems[index];
                    return _buildFoodCard(food);
                  },
                ),
              ),
            ),
          ],
        ),
      ),

 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomIndex,
        onTap: (i) => setState(() => bottomIndex = i),
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
       
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }


   Widget _buildFoodCard(Map<String, String> food) {
    return GestureDetector(
     
      onTap: () {
      
        Navigator.push(
          context,
          MaterialPageRoute(
          
            builder: (context) => FoodDetailScreen(foodItem: food),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(food["image"]!,
                    height: 130, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(Icons.favorite_border,
                      size: 18, color: Colors.red),
                ),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(food["name"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    const SizedBox(width: 2),
                    Text(food["rating"]!,
                        style: const TextStyle(color: Colors.grey)),
                    const Spacer(),
                    const Icon(Icons.location_on,
                        size: 14, color: Colors.orange),
                    Text(food["distance"]!,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Text("\$ ${food["price"]}",
                    style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ],
            ),
          )
        ],
      ),
    );
  }
}